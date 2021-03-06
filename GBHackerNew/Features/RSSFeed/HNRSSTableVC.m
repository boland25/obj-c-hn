//
//  HNRSSTableVC.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNRSSTableVC.h"
#import "HNRSSItemCell.h"
#import "HNDataController.h"
#import "HNError.h"
#import "HNRSSDetailsVC.h"
#import "UIColor+RandomColor.h"

@interface HNRSSTableVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *feedsArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HNRSSTableVC

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupRefreshControl];
	self.title = @"Hacker News Feed";
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//NOTE: this is so that it will reload itself everytime this view is on screen
	[self getFeeds];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.feedsArray.count;
}

#pragma mark UITableViewDelegate

- (HNRSSItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	HNRSSItemCell *cell = [tableView dequeueReusableCellWithIdentifier:HN_RSS_ITEM_CELL forIndexPath:indexPath];

	[cell layoutWithItem:self.feedsArray[indexPath.row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Private methods

- (void)getFeeds {
	if (!self.refreshControl.isRefreshing) {
		[self showActivityIndicator];
	}
	[[HNDataController sharedData] getFeeds: ^(NSArray *feeds) {
	    self.feedsArray = [HNRSSItem arrayFromJSONArray:feeds];
	    [self.tableView reloadData];
	    [self.refreshControl endRefreshing];
	    [self hideActivityIndicator];
	} failure: ^(HNError *error) {
	    [self showError:error];
	    [self hideActivityIndicator];
	    [self.refreshControl endRefreshing];
	}];
}

- (void)refreshTableFeed:(UIRefreshControl *)refreshControl {
	[self.refreshControl beginRefreshing];
	self.refreshControl.tintColor = [UIColor randomColor];
	[self getFeeds];
}

- (void)setupRefreshControl {
	self.refreshControl = [[UIRefreshControl alloc]init];
	[self.tableView addSubview:self.refreshControl];
	[self.refreshControl addTarget:self action:@selector(refreshTableFeed:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showDetailsVC"]) {
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		HNRSSItem *object = self.feedsArray[indexPath.row];
		HNRSSDetailsVC *detailVC =  (HNRSSDetailsVC *)segue.destinationViewController;
		detailVC.detailItem = object;
	}
}

@end
