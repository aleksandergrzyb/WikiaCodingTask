//
//  WSliderHandle.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 19/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WSliderHandle.h"

// Handles Size & Position
static CGFloat const WSliderHandleCornerRadius = 14.0f;
static CGFloat const WSliderShadowRadius = 3.0f;
static CGFloat const WSliderShadowOpacity = 5.0f;
static CGFloat const WSliderShadowOffsetHight = 2.5f;
static CGFloat const WSliderShadowOffsetWidth = 0.0f;

// Touch area margin
static CGFloat const WTouchAreaMargin = 15.0f;

@implementation WSliderHandle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.cornerRadius = WSliderHandleCornerRadius;
        self.layer.shadowColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1].CGColor;
        self.layer.shadowRadius = WSliderShadowRadius;
        self.layer.shadowOpacity = WSliderShadowOpacity;
        self.layer.shadowOffset = CGSizeMake(WSliderShadowOffsetWidth, WSliderShadowOffsetHight);
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect area = CGRectInset(self.bounds, -WTouchAreaMargin, -WTouchAreaMargin);
    return CGRectContainsPoint(area, point);
}

+ (CGFloat)touchMargin
{
    return WTouchAreaMargin;
}

@end
