//
//  WMainTabBarController.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WMainTabBarController.h"
#import "WPopularWikisTableViewController.h"
#import "WSliderDemoViewController.h"

@implementation WMainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViewControllers];
}

- (void)addViewControllers
{
    WPopularWikisTableViewController *popularWikisTVC = [[WPopularWikisTableViewController alloc] init];
    popularWikisTVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:0];
    
    WSliderDemoViewController *sliderDemoVC = [[WSliderDemoViewController alloc] init];
    sliderDemoVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
    
    NSArray *viewControllers = @[popularWikisTVC, sliderDemoVC];
    self.viewControllers = viewControllers;
}

@end
