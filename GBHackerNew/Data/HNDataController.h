//
//  HNDataController.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNError.h"

@interface HNDataController : NSObject

+ (instancetype)sharedData;

- (void)getFeeds:(void (^)(NSArray *feeds))success failure:(void (^)(HNError *error))failure;

- (void)getComments:(NSString *)commentPath success:(void (^)(NSString *htmlString))success failure:(void (^)(HNError *error))failure;

@end
