//
//  WPopularWikisTableViewController.m
//  WikiaCodingTask
//
//  Created by Aleksander Grzyb on 15/07/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "WPopularWikisTableViewController.h"
#import "WAPIClient.h"
#import "WWiki.h"

@interface WPopularWikisTableViewController ()
@property (strong, nonatomic) NSMutableArray *wikis;
@end

static NSString * const WMostPopularWikisCellIdentifier = @"MostPopularWikisCell";

@implementation WPopularWikisTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Most Popular Wikis";
    [self fetchWikis];
    [self addRefreshControl];
}

#pragma mark - Getters & Setters

- (NSMutableArray *)wikis
{
    if (!_wikis) {
        _wikis = [[NSMutableArray alloc] init];
    }
    return _wikis;
}

#pragma mark - Setting Up Data & Objects

- (void)fetchWikis
{
    [[[WAPIClient sharedAPIClient] fetchMostPopularWikis] subscribeNext:^(id mostPopularWikis) {
        [self.wikis addObjectsFromArray:(NSArray *)mostPopularWikis];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)addRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wikis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WMostPopularWikisCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:WMostPopularWikisCellIdentifier];
    }
    if (indexPath.row < self.wikis.count) {
        WWiki *wiki = self.wikis[indexPath.row];
        cell.textLabel.text = wiki.name;
        cell.detailTextLabel.text = wiki.domain;
    }
    return cell;
}

#pragma mark - Actions

- (void)refreshData
{
    [self.wikis removeAllObjects];
    [self fetchWikis];
}

@end
