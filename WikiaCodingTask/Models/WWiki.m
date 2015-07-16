//
//  WWiki.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WWiki.h"
#import "MTLValueTransformer.h"

@implementation WWiki

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name" : @"name",
             @"domain" : @"domain",
             @"identifier" : @"id",
             @"imageURL" : @"wordmark"
    };
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:value];
    }];
}

@end
