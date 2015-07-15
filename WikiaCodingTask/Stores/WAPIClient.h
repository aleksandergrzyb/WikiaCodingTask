//
//  WAPIClient.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "ReactiveCocoa.h"

@interface WAPIClient : AFHTTPSessionManager

+ (WAPIClient *)sharedAPIClient;
- (RACSignal *)fetchMostPopularWikis;

@end
