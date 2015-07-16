//
//  WTwoThumbSlider.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 16/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTwoThumbSlider : UIControl <UIGestureRecognizerDelegate>

@property (nonatomic) float leftValue;
@property (nonatomic) float rightValue;
@property (nonatomic) float minDistance;

@end
