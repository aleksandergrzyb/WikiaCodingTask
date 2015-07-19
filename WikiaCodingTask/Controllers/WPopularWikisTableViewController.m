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
#import "UIImageView+WebCache.h"
#import "WPopularWikiCell.h"

@interface WPopularWikisTableViewController ()
@property (strong, nonatomic) NSMutableArray *wikis;
@end

static NSString * const WMostPopularWikisCellIdentifier = @"MostPopularWikisCell";
static NSString * const WImageDownloadedNotificationName = @"ImageDownloaded";

static int const WNumberOfRowsToRefresh = 3;

@implementation WPopularWikisTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Most Popular Wikis";
    self.tableView.allowsSelection = NO;
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

#pragma mark - Setting Up UI

- (void)addRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Networking

- (void)fetchWikis
{
    [[[WAPIClient sharedAPIClient] fetchMostPopularWikis] subscribeNext:^(id mostPopularWikis) {
        [self.wikis addObjectsFromArray:(NSArray *)mostPopularWikis];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"Error when fetching: %@", [error localizedDescription]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Network Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self.refreshControl endRefreshing];
        [alertView show];
    }];
}



#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wikis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WPopularWikiCell *cell = [tableView dequeueReusableCellWithIdentifier:WMostPopularWikisCellIdentifier];
    if (!cell) {
        cell = [[WPopularWikiCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:WMostPopularWikisCellIdentifier];
    }
    if (indexPath.row < self.wikis.count) {
        WWiki *wiki = self.wikis[indexPath.row];
        cell.name = wiki.name;
        cell.domain = wiki.domain;
        [cell.thumbnail sd_setImageWithURL:wiki.imageURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return cell;
}

#pragma mark - Table View Delegate

// Downloading more wikis when user gets to the bottom of table view.
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.wikis.count - WNumberOfRowsToRefresh) {
        if ([WAPIClient sharedAPIClient].currentBatch <= [WAPIClient sharedAPIClient].numberOfBatches) {
            [self fetchWikis];
        }
    }
}

#pragma mark - Actions

// Refreshing removes all downloaded wikis from model and downloads again top25 wikis.
- (void)refreshData
{
    [self.wikis removeAllObjects];
    [[WAPIClient sharedAPIClient] resetBatches];
    [self fetchWikis];
}

@end
