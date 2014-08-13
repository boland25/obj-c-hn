//
//  HNModel.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNModel.h"

@implementation HNModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{};
}

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)JSONDictionary {
	NSError *error = nil;
	return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:JSONDictionary error:&error];
}

+ (NSArray *)arrayFromJSONArray:(NSArray *)array {
	NSValueTransformer *valueTransformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[self class]];
	NSMutableArray *objects = [valueTransformer transformedValue:array];

	return objects;
}

// Override Mantle's default behavior to overwrite good values with a potential nil from the incoming model
- (void)mergeValueForKey:(NSString *)key fromModel:(MTLModel *)model {
	if ([model valueForKey:key]) {
		[super mergeValueForKey:key fromModel:model];
	}
}

@end
