//
//  TwoThumbSliderTest.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 19/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "Kiwi.h"
#import "WTwoThumbSlider.h"

SPEC_BEGIN(TwoThumbSliderSpec)

describe(@"two thumb slider", ^{
    
    __block WTwoThumbSlider *slider;
    
    beforeEach(^{
        slider = [[WTwoThumbSlider alloc] init];
    });

    context(@"left value", ^{
        it(@"should be greater or equal than zero", ^{
            slider.leftValue = -1;
            [[@(slider.leftValue) should] beGreaterThanOrEqualTo:@(0)];
        });
        
        it(@"should be less or equal than one", ^{
            slider.leftValue = 2;
            [[@(slider.leftValue) should] beLessThanOrEqualTo:@(1)];
        });
    
        it(@"should be less or equal than right value", ^{
            slider.leftValue = 2;
            slider.rightValue = 0.5;
            [[@(slider.leftValue) should] beLessThanOrEqualTo:@(slider.rightValue)];
        });
        
        it(@"should be less or equal than right value minus minimum distance", ^{
            slider.minDistance = 0.5;
            slider.leftValue = 2;
            slider.rightValue = 0.5;
            [[@(slider.leftValue) should] beLessThanOrEqualTo:@(slider.rightValue - slider.minDistance)];
        });
    });
    
    context(@"right value", ^{
        it(@"should be greater or equal than zero", ^{
            slider.rightValue = -0.5;
            [[@(slider.rightValue) should] beGreaterThanOrEqualTo:@(0)];
        });
        
        it(@"should be less or equal than one", ^{
            slider.rightValue = 2;
            [[@(slider.rightValue) should] beLessThanOrEqualTo:@(1)];
        });
        
        it(@"should be greater or equal than left value", ^{
            slider.leftValue = 0.9;
            slider.rightValue = 0.7;
            [[@(slider.rightValue) should] beGreaterThanOrEqualTo:@(slider.leftValue)];
        });
        
        it(@"should be greater or equal than left value plus minimum distance", ^{
            slider.minDistance = 0.7;
            slider.leftValue = 1.5;
            slider.rightValue = 0.9;
            [[@(slider.rightValue) should] beGreaterThanOrEqualTo:@(slider.leftValue + slider.minDistance)];
        });
    });
    
    context(@"minimum distance value", ^{
        it(@"should be greater or equal than zero", ^{
            slider.minDistance = -0.5;
            [[@(slider.minDistance) should] beGreaterThanOrEqualTo:@(0)];
        });
        
        it(@"should be less or equal than one", ^{
            slider.minDistance = 2;
            [[@(slider.minDistance) should] beLessThanOrEqualTo:@(1)];
        });
        
        it(@"should reset left value and right value to default values", ^{
            slider.minDistance = 0.5;
            [[@(slider.leftValue) should] equal:@(0)];
            [[@(slider.rightValue) should] equal:@(1)];
        });
    });
});

SPEC_END
