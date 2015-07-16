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
    return [super initWithBaseURL:url];
}

- (RACSignal *)fetchMostPopularWikis
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *params = @{ @"expand" : @"yes" };
        NSURLSessionDataTask *sessionDataTask = [self GET:@"" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *results = responseObject[@"items"];
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

@end
