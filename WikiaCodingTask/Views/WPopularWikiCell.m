//
//  WPopularWikiCell.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 16/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WPopularWikiCell.h"
#import "Masonry.h"

static CGFloat const WDomainLabelFontSize = 12.0f;
static CGFloat const WNameLabelFontSize = 14.0f;

@interface WPopularWikiCell ()
@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UILabel *domainLabel;
@end

@implementation WPopularWikiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Label that prints the name of wiki.
        UILabel *nameLabel = [[UILabel alloc] init];
        self.nameLabel = nameLabel;
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nameLabel.font = [UIFont systemFontOfSize:WNameLabelFontSize];
        self.nameLabel.textColor = [UIColor blackColor];
        [self addSubview:self.nameLabel];
        
        // Label that prints the webpage of wiki.
        UILabel *domainLabel = [[UILabel alloc] init];
        self.domainLabel = domainLabel;
        self.domainLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.domainLabel.font = [UIFont systemFontOfSize:WDomainLabelFontSize];
        self.domainLabel.textColor = [UIColor blueColor];
        [self addSubview:self.domainLabel];
        
        // ImageView that holds thumbnail of wiki.
        UIImageView *thumbnail = [[UIImageView alloc] init];
        self.thumbnail = thumbnail;
        self.thumbnail.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.thumbnail];
    }
    return self;
}

#pragma mark - Auto Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(4, 8, 4, 8);
    
    [self.thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(padding.top);
        make.left.equalTo(self.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.mas_bottom).with.offset(-padding.bottom);
        make.width.equalTo(@(100));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(padding.top);
        make.right.equalTo(self.mas_right).with.offset(-padding.right);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(padding.left);
    }];
    
    [self.domainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(padding.left);
        make.bottom.equalTo(self.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(self.mas_right).with.offset(-padding.right);
    }];
}

#pragma mark - Setters

- (void)setName:(NSString *)name
{
    if (_name == name) {
        return;
    }
    _name = name;
    self.nameLabel.text = name;
    [self setNeedsDisplay];
}

- (void)setDomain:(NSString *)domain
{
    if (_domain == domain) {
        return;
    }
    _domain = domain;
    self.domainLabel.text = domain;
    [self setNeedsDisplay];
}

@end
