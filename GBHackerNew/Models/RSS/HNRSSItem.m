//
//  HNRSSItem.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNRSSItem.h"

@implementation HNRSSItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{ @"title":@"title",
			  @"link":@"link",
			  @"comments":@"comments",
			  @"hnDescription":@"description" };
}

@end
