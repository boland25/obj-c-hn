//
//  HNError.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNError.h"

@implementation HNError

+ (HNError *)createError:(NSString *)message {
	return [HNError modelFromJSONDictionary:@{ @"message":message }];
}

@end
