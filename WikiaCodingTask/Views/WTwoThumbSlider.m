//
//  WTwoThumbSlider.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 16/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WTwoThumbSlider.h"

// Handles Size & Position
static CGFloat const WSliderHeight = 28.0f;
static CGFloat const WSliderCornerRadius = 14.0f;
static CGFloat const WSliderShadowRadius = 2.0f;
static CGFloat const WSliderShadowOpacity = 0.5f;
static CGFloat const WSliderShadowOffsetHight = 2.0f;
static CGFloat const WSliderShadowOffsetWidth = 0.0f;

// Line Size & Position
static CGFloat const WSliderLineXCor = WSliderHeight * 0.5;
static CGFloat const WSliderLineYCor = WSliderHeight * 0.5 - 1;
static CGFloat const WSliderLineHeight = 2.0;

@interface WTwoThumbSlider ()
@property (weak, nonatomic) CALayer *sliderLine;
@property (weak, nonatomic) CALayer *rightHandle;
@property (weak, nonatomic) CALayer *leftHandle;
@end

@implementation WTwoThumbSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialise];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialise];
    }
    return self;
}

#pragma mark - Custom Initialization

- (void)initialise
{
    // Default values
    self.minDistance = 0;
    self.leftValue = 0;
    self.rightValue = 1;
    
    // Adding UI
    CALayer *sliderLine = [CALayer layer];
    self.sliderLine = sliderLine;
    self.sliderLine.backgroundColor = [UIColor colorWithRed:0.09 green:0.5 blue:0.99 alpha:1].CGColor;
    [self.layer addSublayer:self.sliderLine];
    
    CALayer *leftHandle = [CALayer layer];
    self.leftHandle = leftHandle;
    self.leftHandle.backgroundColor = [UIColor whiteColor].CGColor;
    self.leftHandle.cornerRadius = WSliderCornerRadius;
    self.leftHandle.shadowColor = [UIColor blackColor].CGColor;
    self.leftHandle.shadowRadius = WSliderShadowRadius;
    self.leftHandle.shadowOpacity = WSliderShadowOpacity;
    self.leftHandle.shadowOffset = CGSizeMake(WSliderShadowOffsetWidth, WSliderShadowOffsetHight);
    [self.layer addSublayer:self.leftHandle];
    
    CALayer *rightHandle = [CALayer layer];
    self.rightHandle = rightHandle;
    self.rightHandle.backgroundColor = [UIColor whiteColor].CGColor;
    self.rightHandle.cornerRadius = WSliderCornerRadius;
    self.rightHandle.shadowColor = [UIColor blackColor].CGColor;
    self.rightHandle.shadowRadius = WSliderShadowRadius;
    self.rightHandle.shadowOpacity = WSliderShadowOpacity;
    self.rightHandle.shadowOffset = CGSizeMake(WSliderShadowOffsetWidth, WSliderShadowOffsetHight);
    [self.layer addSublayer:self.rightHandle];
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, WSliderHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.sliderLine.frame = CGRectMake(WSliderLineXCor, WSliderLineYCor, self.frame.size.width - WSliderHeight, WSliderLineHeight);
    self.leftHandle.frame = CGRectMake(self.leftValue * self.frame.size.width, 0.0f, WSliderHeight, WSliderHeight);
    self.rightHandle.frame = CGRectMake(self.rightValue * self.frame.size.width - WSliderHeight, 0.0f, WSliderHeight, WSliderHeight);
}

#pragma mark - Setters

- (void)setLeftValue:(float)leftValue
{
    if (_leftValue == leftValue) {
        return;
    }
    if (leftValue >= 0 && leftValue <= self.rightValue) {
        _leftValue = leftValue;
        [self setNeedsDisplay];
    }
}

- (void)setRightValue:(float)rightValue
{
    if (_rightValue == rightValue) {
        return;
    }
    if (rightValue <= 1 && self.leftValue <= rightValue) {
        _rightValue = rightValue;
        [self setNeedsDisplay];
    }
}


@end











