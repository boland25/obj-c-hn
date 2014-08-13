//
//  NSDictionary+NilValue.m
//  Greenpoint
//
//  Created by boland on 5/14/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

#import "NSDictionary+NilValue.h"

@implementation NSDictionary (NilValue)

- (id)contains:(NSString *)key
{
    return ([self valueForKey:key]) ? [self valueForKey:key] : @"";
}

- (BOOL)hasValueForKey:(NSString *)key
{
    id value = [self valueForKey:key];
    return (value && ![value isKindOfClass:[NSNull class]]);
}

@end
