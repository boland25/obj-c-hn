//
//  HNRSSItemCell.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNRSSItem.h"

static NSString *const HN_RSS_ITEM_CELL = @"HNRSSItemCell";

@interface HNRSSItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

- (void)layoutWithItem:(HNRSSItem *)item;

@end
