//
//  WSliderHandle.h
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 19/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSliderHandle : UIView

/**
 * Returns value of margin around handle in which handle still can receive hit tests. This was developed to make
 * handles usage more easy and pleasent.
 */
+ (CGFloat)touchMargin;

@end
