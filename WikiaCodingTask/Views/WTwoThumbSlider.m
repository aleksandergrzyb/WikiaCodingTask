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
static CGFloat const WSliderHandleCornerRadius = 14.0f;
static CGFloat const WSliderCornerRadius = 1.0f;
static CGFloat const WSliderShadowRadius = 3.0f;
static CGFloat const WSliderShadowOpacity = 5.0f;
static CGFloat const WSliderShadowOffsetHight = 2.5f;
static CGFloat const WSliderShadowOffsetWidth = 0.0f;

// Line Size & Position
static CGFloat const WSliderLineXCor = 0.0f;
static CGFloat const WSliderLineYCor = WSliderSize * 0.5 - 1;
static CGFloat const WSliderLineHeight = 2.0;

@interface WTwoThumbSlider ()

// Layers of slider
@property (weak, nonatomic) CALayer *sliderLine;
@property (weak, nonatomic) CALayer *sliderUsedLine;

// Handlers
@property (weak, nonatomic) UIView *leftHandleView;
@property (weak, nonatomic) UIView *rightHandleView;

// Helpers for touch handling
@property (nonatomic) BOOL leftHandleTouched;
@property (nonatomic) BOOL wasLeftTouchInside;
@property (nonatomic) BOOL rightHandleTouched;
@property (nonatomic) BOOL wasRightTouchInside;
@property (nonatomic) CGPoint previouslyTouchedLeftPoint;
@property (nonatomic) CGPoint previouslyTouchedRightPoint;
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
    
    // Enabling mulititouch
    self.multipleTouchEnabled = YES;
    
    // Adding UI
    CALayer *sliderUsedLine = [CALayer layer];
    self.sliderUsedLine = sliderUsedLine;
    self.sliderUsedLine.cornerRadius = WSliderCornerRadius;
    self.sliderUsedLine.backgroundColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1].CGColor;
    [self.layer addSublayer:self.sliderUsedLine];
    
    CALayer *sliderLine = [CALayer layer];
    self.sliderLine = sliderLine;
    self.sliderLine.cornerRadius = WSliderCornerRadius;
    self.sliderLine.backgroundColor = [UIColor colorWithRed:0 green:0.48 blue:1 alpha:1].CGColor;
    [self.layer addSublayer:self.sliderLine];
    
    // Adding handles
    UIView *leftHandleView = [[UIView alloc] init];
    self.leftHandleView = leftHandleView;
    self.leftHandleView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.leftHandleView.layer.cornerRadius = WSliderHandleCornerRadius;
    self.leftHandleView.layer.shadowColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1].CGColor;
    self.leftHandleView.layer.shadowRadius = WSliderShadowRadius;
    self.leftHandleView.layer.shadowOpacity = WSliderShadowOpacity;
    self.leftHandleView.layer.shadowOffset = CGSizeMake(WSliderShadowOffsetWidth, WSliderShadowOffsetHight);
    [self addSubview:self.leftHandleView];
    
    UIView *rightHandleView = [[UIView alloc] init];
    self.rightHandleView = rightHandleView;
    self.rightHandleView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.rightHandleView.layer.cornerRadius = WSliderHandleCornerRadius;
    self.rightHandleView.layer.shadowColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1].CGColor;
    self.rightHandleView.layer.shadowRadius = WSliderShadowRadius;
    self.rightHandleView.layer.shadowOpacity = WSliderShadowOpacity;
    self.rightHandleView.layer.shadowOffset = CGSizeMake(WSliderShadowOffsetWidth, WSliderShadowOffsetHight);
    [self addSubview:self.rightHandleView];
    
    // Adding gesture recognizers
    UIPanGestureRecognizer *leftPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
    [self.leftHandleView addGestureRecognizer:leftPanRecognizer];
    
    UIPanGestureRecognizer *rightPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightPan:)];
    [self.rightHandleView addGestureRecognizer:rightPanRecognizer];
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
    self.sliderUsedLine.frame = CGRectMake(WSliderLineXCor, WSliderLineYCor, self.frame.size.width, WSliderLineHeight);
    self.leftHandleView.frame = CGRectMake([self xPositionOfLeftHandle:self.leftValue], 0.0f, WSliderSize, WSliderSize);
    self.rightHandleView.frame = CGRectMake([self xPositionOfRightHandle:self.rightValue], 0.0f, WSliderSize, WSliderSize);
}

- (void)updatePositions
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES] ;
    self.leftHandleView.frame = CGRectMake([self xPositionOfLeftHandle:self.leftValue], 0.0f, WSliderSize, WSliderSize);
    self.rightHandleView.frame = CGRectMake([self xPositionOfRightHandle:self.rightValue], 0.0f, WSliderSize, WSliderSize);
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

- (void)setMinDistance:(float)minDistance
{
    if (_minDistance == minDistance) {
        return;
    }
    if (minDistance < 0) {
        _minDistance = 0;
    } else if (minDistance > 1) {
        _minDistance = 1;
    } else {
        _minDistance = minDistance;
    }
}

#pragma mark - Gesture Recognizer Delegate

- (void)handleLeftPan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [gesture locationInView:self];
        self.previouslyTouchedLeftPoint = touchPoint;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint touchPoint = [gesture locationInView:self];
        CGFloat deltaX = touchPoint.x - self.previouslyTouchedLeftPoint.x;
        self.previouslyTouchedLeftPoint = touchPoint;
        
        BOOL isLeftHandleBeforeEnd = self.leftHandleView.center.x >= CGRectGetMinX(self.sliderUsedLine.frame);
        BOOL isTouchInBeforeEnd = touchPoint.x >= CGRectGetMinX(self.sliderUsedLine.frame);
        
        // Finishing right move (when finger is going fast over the frame)
        if (!isTouchInBeforeEnd && deltaX < 0 && self.wasLeftTouchInside) {
            self.leftValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
        }
        
        // Checking if delta is not too big (case when handle is getting closer to other handle)
        BOOL isLeftHandleBeforeRightHandle = floor(CGRectGetMinX(self.rightHandleView.frame)) >= floor(CGRectGetMaxX(self.leftHandleView.frame) + [self pointsFromMinDistance]);
        if (isLeftHandleBeforeEnd && isTouchInBeforeEnd && isLeftHandleBeforeRightHandle) {
            CGFloat tempPosition = [self xPositionOfLeftHandle:self.leftValue + deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize)];
            if (tempPosition + [self pointsFromMinDistance] + WSliderSize > CGRectGetMinX(self.rightHandleView.frame)) {
                self.leftValue = self.rightValue - self.minDistance;
            } else {
                self.leftValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
            }
            self.wasLeftTouchInside = YES;
        }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        self.wasLeftTouchInside = NO;
    }
}

- (void)handleRightPan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [gesture locationInView:self];
        self.previouslyTouchedRightPoint = touchPoint;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint touchPoint = [gesture locationInView:self];
        CGFloat deltaX = touchPoint.x - self.previouslyTouchedRightPoint.x;
        self.previouslyTouchedRightPoint = touchPoint;
        
        BOOL isRightHandleBeforeEnd = self.rightHandleView.center.x <= CGRectGetMaxX(self.sliderUsedLine.frame);
        BOOL isTouchInBeforeEnd = touchPoint.x <= CGRectGetMaxX(self.sliderUsedLine.frame);
        
        // Finishing right move (when finger is going fast over the frame)
        if (!isTouchInBeforeEnd && deltaX > 0 && self.wasRightTouchInside) {
            self.rightValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
        }
        
        BOOL isRightHandleBeforeLeftHandle = floor(CGRectGetMinX(self.rightHandleView.frame)) >= floor(CGRectGetMaxX(self.leftHandleView.frame) + [self pointsFromMinDistance]);
        if (isRightHandleBeforeEnd && isTouchInBeforeEnd && isRightHandleBeforeLeftHandle) {
            
            // Checking if delta is not too big (case when handle is getting closer to other handle)
            CGFloat tempPosition = [self xPositionOfRightHandle:self.rightValue + deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize)];
            if (tempPosition < CGRectGetMaxX(self.leftHandleView.frame) + [self pointsFromMinDistance]) {
                self.rightValue = self.leftValue + self.minDistance;
            } else {
                self.rightValue += deltaX / (self.sliderUsedLine.frame.size.width - WSliderSize);
            }
            self.wasRightTouchInside = YES;
        }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        self.wasRightTouchInside = NO;
    }
}

#pragma mark - Helpers

- (CGFloat)pointsFromMinDistance
{
    return self.minDistance * (self.sliderUsedLine.frame.size.width - 2 * WSliderSize);
}

- (CGFloat)xPositionOfRightHandle:(CGFloat)value
{
    return value * (self.sliderUsedLine.frame.size.width - 2 * WSliderSize) + WSliderSize;
}

- (CGFloat)xPositionOfLeftHandle:(CGFloat)value
{
    return value * (self.sliderUsedLine.frame.size.width - 2 * WSliderSize);
}

- (CGFloat)distanceFromPoint:(CGPoint)pointOne toPoint:(CGPoint)pointTwo
{
    return sqrtf(powf(pointOne.x - pointTwo.x, 2.0f) + powf(pointOne.y - pointTwo.y, 2.0f));
}

@end











