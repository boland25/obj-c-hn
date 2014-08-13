//
//  NSDictionary+NilValue.h
//  Greenpoint
//
//  Created by boland on 5/14/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NilValue)

- (id)contains:(NSString *)key;

- (BOOL)hasValueForKey:(NSString *)key;

@end
