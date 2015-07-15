//
//  WWiki.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface WWiki : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *domain;
@property (copy, nonatomic) NSNumber *identifier;

@end
