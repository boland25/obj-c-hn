//
//  HNNetworking.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNError.h"
#import "AFHTTPSessionManager.h"

static NSString *const GET  = @"GET";
static NSString *const POST = @"POST";

typedef NS_ENUM (NSInteger, HNRequestHandlerMethod)
{
	HNRequestMethodPOST,
	HNRequestMethodGET,
	HNRequestMethodDELETE,
	HNRequestMethodPUT
};

@interface HNNetworking : NSObject

- (HNError *)createErrorModelFromResponse:(id)errorResponse error:(NSError *)error;

+ (void)requestWithEndpoint:(NSString *)endpoint method:(HNRequestHandlerMethod)method params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(HNError *error))failure;


@end
