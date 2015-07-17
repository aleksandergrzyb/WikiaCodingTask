//
//  WSliderDemoViewController.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WSliderDemoViewController.h"
#import "WTwoThumbSlider.h"
#import "Masonry.h"

@interface WSliderDemoViewController ()
@property (weak, nonatomic) WTwoThumbSlider *twoThumbSlider;
@end

@implementation WSliderDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Slider Demo";
    self.view.backgroundColor = [UIColor whiteColor];

    WTwoThumbSlider *twoThumbSlider = [[WTwoThumbSlider alloc] init];
    self.twoThumbSlider = twoThumbSlider;
    [self.view addSubview:self.twoThumbSlider];
}

#pragma mark - Auto Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.twoThumbSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(300));
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
}

@end
