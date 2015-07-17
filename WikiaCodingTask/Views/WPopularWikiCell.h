//
//  WPopularWikiCell.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 16/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPopularWikiCell : UITableViewCell

/**
 * Title of the wiki page.
 */
@property (strong, nonatomic) NSString *name;

/**
 * Webpage URL of the wiki page.
 */
@property (strong, nonatomic) NSString *domain;

/**
 * View that displays thumbnail of the wiki page.
 */
@property (weak, nonatomic) UIImageView *thumbnail;

@end
