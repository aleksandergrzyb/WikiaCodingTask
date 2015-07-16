//
//  WAPIClient.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WAPIClient.h"
#import "Mantle.h"
#import "SDWebImageManager.h"

static NSString * const WBaseURL = @"http://www.wikia.com/wikia.php?controller=WikisApi&method=getList";

@interface WAPIClient ()
@property (strong, nonatomic, readwrite) NSNumber *numberOfBatches;
@property (strong, nonatomic, readwrite) NSNumber *currentBatch;
@end

@implementation WAPIClient

+ (WAPIClient *)sharedAPIClient
{
    static WAPIClient *sharedAPIClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:WBaseURL]];
    });
    return sharedAPIClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.currentBatch = @(1);
        self.numberOfBatches = @(1);
    }
    return self;
}

- (RACSignal *)fetchMostPopularWikis
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *params = @{ @"expand" : @"yes", @"batch" : [NSString stringWithFormat:@"%d", [self.currentBatch intValue]] };
        self.currentBatch = [NSNumber numberWithInt:[self.currentBatch intValue] + 1];
        NSURLSessionDataTask *sessionDataTask = [self GET:@"" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *results = responseObject[@"items"];
            self.numberOfBatches = responseObject[@"batches"];
            NSArray *wikisObjects = [MTLJSONAdapter modelsOfClass:[WWiki class] fromJSONArray:results error:nil];
            [subscriber sendNext:wikisObjects];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [sessionDataTask cancel];
        }];
    }] replayLazily];
}

- (void)resetBatches
{
    self.currentBatch = @(1);
}

@end
