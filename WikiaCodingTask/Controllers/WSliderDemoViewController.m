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

static CGFloat const WValueLabelsFontSize = 20.0f;
static int const WValueLabelsPadding = 10;
static int const WSliderWidth = 300;

@interface WSliderDemoViewController ()
@property (weak, nonatomic) WTwoThumbSlider *twoThumbSlider;
@property (weak, nonatomic) UILabel *leftValueLabel;
@property (weak, nonatomic) UILabel *rightValueLabel;
@end

@implementation WSliderDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Slider Demo";
    self.view.backgroundColor = [UIColor whiteColor];

    WTwoThumbSlider *twoThumbSlider = [[WTwoThumbSlider alloc] init];
    self.twoThumbSlider = twoThumbSlider;
    [self.twoThumbSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.twoThumbSlider];
    
    UILabel *leftValueLabel = [[UILabel alloc] init];
    self.leftValueLabel = leftValueLabel;
    self.leftValueLabel.textColor = [UIColor blackColor];
    self.leftValueLabel.font = [UIFont systemFontOfSize:WValueLabelsFontSize];
    self.leftValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view addSubview:self.leftValueLabel];
    
    UILabel *rightValueLabel = [[UILabel alloc] init];
    self.rightValueLabel = rightValueLabel;
    self.rightValueLabel.textColor = [UIColor blackColor];
    self.rightValueLabel.font = [UIFont systemFontOfSize:WValueLabelsFontSize];
    self.rightValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view addSubview:self.rightValueLabel];
    
    [self setLabelsLeftValue:self.twoThumbSlider.leftValue rightValue:self.twoThumbSlider.rightValue];
}

#pragma mark - Auto Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.twoThumbSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(WSliderWidth));
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    [self.leftValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *topLayoutGuide = (id)self.topLayoutGuide;
        make.left.equalTo(self.view.mas_left).with.offset(WValueLabelsPadding);
        make.top.equalTo(topLayoutGuide.mas_bottom).with.offset(WValueLabelsPadding);
    }];
    
    [self.rightValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(WValueLabelsPadding);
        make.top.equalTo(self.leftValueLabel.mas_bottom).with.offset(WValueLabelsPadding);
    }];
}

#pragma mark - Slider Action

- (void)sliderValueChanged:(WTwoThumbSlider *)sender
{
    [self setLabelsLeftValue:sender.leftValue rightValue:sender.rightValue];
}

#pragma mark - Helpers

- (void)setLabelsLeftValue:(float)leftValue rightValue:(float)rightValue
{
    self.leftValueLabel.text = [NSString stringWithFormat:@"Left value: %f", leftValue];
    self.rightValueLabel.text = [NSString stringWithFormat:@"Right value: %f", rightValue];
}

@end
