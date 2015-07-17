//
//  WTwoThumbSlider.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 16/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WTwoThumbSlider.h"

// Handles Size & Position
static CGFloat const WSliderSize = 28.0f;
static CGFloat const WSliderCornerRadius = 14.0f;
static CGFloat const WSliderShadowRadius = 2.0f;
static CGFloat const WSliderShadowOpacity = 0.5f;
static CGFloat const WSliderShadowOffsetHight = 2.0f;
static CGFloat const WSliderShadowOffsetWidth = 0.0f;

// Line Size & Position
static CGFloat const WSliderLineXCor = WSliderSize * 0.5;
static CGFloat const WSliderLineYCor = WSliderSize * 0.5 - 1;
static CGFloat const WSliderLineHeight = 2.0;

// Handle Touch Area
static int const WSliderHandleTouchArea = 20;

@interface WTwoThumbSlider ()

// Layers of slider
@property (weak, nonatomic) CALayer *sliderLine;
@property (weak, nonatomic) CALayer *sliderUsedLine;
@property (weak, nonatomic) CALayer *rightHandle;
@property (weak, nonatomic) CALayer *leftHandle;

// Helpers for touch handling
@property (nonatomic) BOOL leftHandleTouched;
@property (nonatomic) BOOL wasLeftTouchInside;
@property (nonatomic) BOOL rightHandleTouched;
@property (nonatomic) BOOL wasRightTouchInside;
@property (nonatomic) CGPoint previouslyTouchedPoint;
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
    CALayer *sliderUsedLine = [CALayer layer];
    self.sliderUsedLine = sliderUsedLine;
    self.sliderUsedLine.backgroundColor = [UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:1].CGColor;
    [self.layer addSublayer:self.sliderUsedLine];
    
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
    return CGSizeMake(UIViewNoIntrinsicMetric, WSliderSize);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.sliderLine.frame = CGRectMake([self xPositionOfLeftHandle:self.leftValue], WSliderLineYCor, [self xPositionOfRightHandle:self.rightValue] - [self xPositionOfLeftHandle:self.leftValue] + WSliderSize, WSliderLineHeight);
    self.sliderUsedLine.frame = CGRectMake(WSliderLineXCor, WSliderLineYCor, self.frame.size.width - WSliderSize, WSliderLineHeight);
    self.leftHandle.frame = CGRectMake([self xPositionOfLeftHandle:self.leftValue], 0.0f, WSliderSize, WSliderSize);
    self.rightHandle.frame = CGRectMake([self xPositionOfRightHandle:self.rightValue], 0.0f, WSliderSize, WSliderSize);
}

- (void)updatePositions
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES] ;
    self.leftHandle.frame = CGRectMake([self xPositionOfLeftHandle:self.leftValue], 0.0f, WSliderSize, WSliderSize);
    self.rightHandle.frame = CGRectMake([self xPositionOfRightHandle:self.rightValue], 0.0f, WSliderSize, WSliderSize);
    self.sliderLine.frame = CGRectMake([self xPositionOfLeftHandle:self.leftValue], WSliderLineYCor, [self xPositionOfRightHandle:self.rightValue] - [self xPositionOfLeftHandle:self.leftValue] + WSliderSize, WSliderLineHeight);
    [CATransaction commit];
}

#pragma mark - Setters

- (void)setLeftValue:(float)leftValue
{
    if (_leftValue == leftValue) {
        return;
    }
    if (leftValue < 0) {
        _leftValue = 0;
    } else if (leftValue > 1) {
        _leftValue = 1;
    } else {
        _leftValue = leftValue;
    }
    [self updatePositions];
}

- (void)setRightValue:(float)rightValue
{
    if (_rightValue == rightValue) {
        return;
    }
    if (rightValue < 0) {
        _rightValue = 0;
    } else if (rightValue > 1) {
        _rightValue = 1;
    } else {
        _rightValue = rightValue;
    }
    [self updatePositions];
}

#pragma mark - Gesture Recognizer Delegate

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    CGPoint touchPoint = [touch locationInView:self];
    
    // Checking if user touched left or right handle
    self.leftHandleTouched = CGRectContainsPoint(CGRectInset(self.leftHandle.frame, -WSliderHandleTouchArea, -WSliderHandleTouchArea), touchPoint);
    self.rightHandleTouched = CGRectContainsPoint(CGRectInset(self.rightHandle.frame, -WSliderHandleTouchArea, -WSliderHandleTouchArea), touchPoint);
    
    if (self.leftHandleTouched || self.rightHandleTouched) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGPoint touchPoint = [touch locationInView:self];
    if (touchPoint.x < self.frame.size.width) {
    }
    CGFloat deltaX = touchPoint.x - self.previouslyTouchedPoint.x;
    self.previouslyTouchedPoint = touchPoint;
    
    // Checking which handle was touched
    if (self.rightHandleTouched) {
        BOOL isRightHandleBeforeEnd = self.rightHandle.position.x <= CGRectGetMaxX(self.sliderUsedLine.frame);
        BOOL isTouchInBeforeEnd = touchPoint.x <= CGRectGetMaxX(self.sliderUsedLine.frame);
        
        // Finishing right move (when finger is going fast over the frame)
        if (!isTouchInBeforeEnd && deltaX > 0 && self.wasRightTouchInside) {
            self.rightValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
        }
        
        BOOL isRightHandleBeforeLeftHandle = CGRectGetMinX(self.rightHandle.frame) >= CGRectGetMaxX(self.leftHandle.frame);
        if (isRightHandleBeforeEnd && isTouchInBeforeEnd && isRightHandleBeforeLeftHandle) {
            
            // Checking if delta is not too big (case when handle is getting closer to other handle)
            CGFloat tempPosition = [self xPositionOfRightHandle:self.rightValue + deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize)];
            if (tempPosition < CGRectGetMaxX(self.leftHandle.frame)) {
                self.rightValue = self.leftValue;
            } else {
                self.rightValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
            }
            self.wasRightTouchInside = YES;
        }
    } else {
        BOOL isLeftHandleBeforeEnd = self.leftHandle.position.x >= CGRectGetMinX(self.sliderUsedLine.frame);
        BOOL isTouchInBeforeEnd = touchPoint.x >= CGRectGetMinX(self.sliderUsedLine.frame);
        
        // Finishing right move (when finger is going fast over the frame)
        if (!isTouchInBeforeEnd && deltaX < 0 && self.wasLeftTouchInside) {
            self.leftValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
        }
        
        // Checking if delta is not too big (case when handle is getting closer to other handle)
        BOOL isLeftHandleBeforeRightHandle = CGRectGetMinX(self.rightHandle.frame) >= CGRectGetMaxX(self.leftHandle.frame);
        if (isLeftHandleBeforeEnd && isTouchInBeforeEnd && isLeftHandleBeforeRightHandle) {
            CGFloat tempPosition = [self xPositionOfLeftHandle:self.leftValue + deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize)];
            if (tempPosition > CGRectGetMinX(self.rightHandle.frame)) {
                self.leftValue = self.rightValue;
            } else {
                self.leftValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
            }
            self.wasLeftTouchInside = YES;
        }
    }
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    self.previouslyTouchedPoint = CGPointZero;
    self.leftHandleTouched = NO;
    self.rightHandleTouched = NO;
    self.wasRightTouchInside = NO;
    self.wasLeftTouchInside = NO;
}

#pragma mark - Helpers

- (CGFloat)xPositionOfRightHandle:(CGFloat)value
{
    return value * (self.sliderUsedLine.frame.size.width - WSliderSize) + WSliderSize;
}

- (CGFloat)xPositionOfLeftHandle:(CGFloat)value
{
    return value * (self.sliderUsedLine.frame.size.width - WSliderSize);
}

@end











