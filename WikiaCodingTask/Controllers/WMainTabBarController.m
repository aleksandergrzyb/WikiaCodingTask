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
    UINavigationController *popularWikisNC = [[UINavigationController alloc] initWithRootViewController:popularWikisTVC];
    
    WSliderDemoViewController *sliderDemoVC = [[WSliderDemoViewController alloc] init];
    sliderDemoVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
    UINavigationController *sliderDemoNC = [[UINavigationController alloc] initWithRootViewController:sliderDemoVC];
    
    NSArray *viewControllers = @[popularWikisNC, sliderDemoNC];
    self.viewControllers = viewControllers;
}

@end
