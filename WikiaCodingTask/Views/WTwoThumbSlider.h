//
//  WTwoThumbSlider.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 16/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTwoThumbSlider : UIControl <UIGestureRecognizerDelegate>


/**
 * Value of the left slider handle. Default value equals 0.0. Values range is between 0.0 and 1.0.
 */
@property (nonatomic) float leftValue;


/**
 * Value of the right slider handle. Default value equals 1.0. Values range is between 0.0 and 1.0.
 */
@property (nonatomic) float rightValue;

/**
 * Minimum distance between left handle and right handle i.e. handles cannot get closer than this distance.
 * Default value equals 1.0. Values range is between 0.0 and 1.0.
 * Setting value of minDistance resets leftValue and rightValue to their default values.
 */
@property (nonatomic) float minDistance;

@end
