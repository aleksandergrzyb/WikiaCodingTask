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

/** 
 * Shared instance of WAPIClient.
 */
+ (WAPIClient *)sharedAPIClient;

/*
 * Fetches most popular wikis from the server using current batch number. 
 * Method performing get request with expand=yes param in order to download thumbnails URLs.
 */
- (RACSignal *)fetchMostPopularWikis;

/**
 * Method resets the current batch number to 1.
 */
- (void)resetBatches;

/**
 * Count of available batches.
 */
@property (strong, nonatomic, readonly) NSNumber *numberOfBatches;

/**
 * Current batch number to be downloaded with fetchMostPopularWikis method.
 */
@property (strong, nonatomic, readonly) NSNumber *currentBatch;

@end
