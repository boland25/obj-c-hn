//
//  HNRSSItem.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNModel.h"

@interface HNRSSItem : HNModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hnDescription;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *comments;

@end
