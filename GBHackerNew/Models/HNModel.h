//
//  HNModel.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface HNModel : MTLModel <MTLJSONSerializing>

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)JSONDictionary;
+ (NSArray *)arrayFromJSONArray:(NSArray *)array;

@end
