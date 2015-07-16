//
//  WAPIClient.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "ReactiveCocoa.h"
#import "WWiki.h"

@interface WAPIClient : AFHTTPSessionManager

+ (WAPIClient *)sharedAPIClient;
- (RACSignal *)fetchMostPopularWikis;
- (void)resetBatches;

@property (strong, nonatomic, readonly) NSNumber *numberOfBatches;
@property (strong, nonatomic, readonly) NSNumber *currentBatch;

@end
