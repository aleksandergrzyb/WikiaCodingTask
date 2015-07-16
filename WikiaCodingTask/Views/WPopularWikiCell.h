//
//  WPopularWikiCell.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 16/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPopularWikiCell : UITableViewCell

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *domain;
@property (weak, nonatomic) UIImageView *thumbnail;

@end
