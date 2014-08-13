//
//  HNRSSItemCell.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNRSSItemCell.h"
#import "UIColor+RandomColor.h"

@implementation HNRSSItemCell

- (void)layoutWithItem:(HNRSSItem *)item {
	self.titleLabel.text =  item.title;
    self.backgroundColor = [UIColor randomColor];
}

@end
