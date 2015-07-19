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

static CGFloat const WLabelsFontSize = 20.0f;
static int const WLabelsPadding = 10;
static int const WSlidersPadding = 40;
static int const WSliderWidth = 300;

@interface WSliderDemoViewController ()
@property (weak, nonatomic) WTwoThumbSlider *twoThumbSlider;
@property (weak, nonatomic) UILabel *leftValueLabel;
@property (weak, nonatomic) UILabel *rightValueLabel;
@property (weak, nonatomic) UISlider *minimumDistanceSlider;
@property (weak, nonatomic) UILabel *minimumDistanceLabel;
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
    self.leftValueLabel.font = [UIFont systemFontOfSize:WLabelsFontSize];
    self.leftValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view addSubview:self.leftValueLabel];
    
    UILabel *rightValueLabel = [[UILabel alloc] init];
    self.rightValueLabel = rightValueLabel;
    self.rightValueLabel.textColor = [UIColor blackColor];
    self.rightValueLabel.font = [UIFont systemFontOfSize:WLabelsFontSize];
    self.rightValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view addSubview:self.rightValueLabel];
    
    [self setLabelsLeftValue:self.twoThumbSlider.leftValue rightValue:self.twoThumbSlider.rightValue];
    
    UISlider *minimumDistanceSlider = [[UISlider alloc] init];
    self.minimumDistanceSlider = minimumDistanceSlider;
    self.minimumDistanceSlider.minimumValue = 0.0f;
    self.minimumDistanceSlider.maximumValue = 1.0f;
    [self.minimumDistanceSlider addTarget:self action:@selector(minimumDistanceValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.minimumDistanceSlider];
    
    UILabel *minimumDistanceLabel = [[UILabel alloc] init];
    self.minimumDistanceLabel = minimumDistanceLabel;
    self.minimumDistanceLabel.textColor = [UIColor blackColor];
    self.minimumDistanceLabel.font = [UIFont systemFontOfSize:WLabelsFontSize];
    self.minimumDistanceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.minimumDistanceLabel.text = [NSString stringWithFormat:@"Minimum distance value: %f", minimumDistanceSlider.value];
    [self.view addSubview:self.minimumDistanceLabel];
}

#pragma mark - Auto Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.leftValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *topLayoutGuide = (id)self.topLayoutGuide;
        make.left.equalTo(self.view.mas_left).with.offset(WLabelsPadding);
        make.top.equalTo(topLayoutGuide.mas_bottom).with.offset(WLabelsPadding);
    }];
    
    [self.rightValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(WLabelsPadding);
        make.top.equalTo(self.leftValueLabel.mas_bottom).with.offset(WLabelsPadding);
    }];
    
    [self.twoThumbSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(WSliderWidth));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.rightValueLabel.mas_bottom).with.offset(WSlidersPadding);
    }];
    
    [self.minimumDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(WLabelsPadding);
        make.top.equalTo(self.twoThumbSlider.mas_bottom).with.offset(WSlidersPadding);
    }];
    
    [self.minimumDistanceSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.minimumDistanceLabel.mas_bottom).with.offset(WSlidersPadding);
        make.width.equalTo(@(WSliderWidth));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma mark - Sliders Action

- (void)sliderValueChanged:(WTwoThumbSlider *)sender
{
    [self setLabelsLeftValue:sender.leftValue rightValue:sender.rightValue];
}

- (void)minimumDistanceValueChanged:(UISlider *)sender
{
    self.minimumDistanceLabel.text = [NSString stringWithFormat:@"Minimum distance value: %f", sender.value];
    self.twoThumbSlider.minDistance = sender.value;
}

#pragma mark - Helpers

- (void)setLabelsLeftValue:(float)leftValue rightValue:(float)rightValue
{
    self.leftValueLabel.text = [NSString stringWithFormat:@"Left value: %f", leftValue];
    self.rightValueLabel.text = [NSString stringWithFormat:@"Right value: %f", rightValue];
}

@end
