//
//  HNNetworking.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNNetworking.h"
#import "HNConstants.h"
#import "NSDictionary+NilValue.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFUrlResponseSerialization.h"

@interface HNNetworking ()

@end

@implementation HNNetworking

+ (void)requestWithEndpoint:(NSString *)endpoint
                     method:(HNRequestHandlerMethod)method
                     params:(NSDictionary *)params
                    success:(void (^)(id))success
                    failure:(void (^)(HNError *))failure {
	[[HNNetworking alloc] initRequestWithEndpoint:endpoint method:method params:params success:success failure:failure];
}

- (void)initRequestWithEndpoint:(NSString *)endpoint method:(HNRequestHandlerMethod)method params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(HNError *error))failure {
	AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:HN_BASE_URL]];

	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];


	NSMutableURLRequest *request = [self requestWithEndpoint:endpoint method:[self requestMethodString:method] params:params sessionManager:manager];


	NSLog(@"Request: %@ \n%@\n", request.HTTPMethod, request.URL.absoluteString);

	if (request.HTTPBody) {
		NSString *postBodyStr = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];

		NSLog(@"Body: %@", postBodyStr);
	}
	__block NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler: ^(NSURLResponse *__unused response, id responseObject, NSError *error) {
	    if (error || ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject hasValueForKey:@"errorMessage"])) {
	        if (failure) {
	            NSLog(@"Response(failure):\n%@\nerror:%@\n", responseObject, error);
	            failure([self createErrorModelFromResponse:responseObject error:error]);
			}
		}
	    else {
	        if (success) {
	            NSLog(@"Response(success):\n%@\n", responseObject);
	            success(responseObject);
			}
		}
	}];

	[task resume];
}

- (NSMutableURLRequest *)requestWithEndpoint:(NSString *)endpoint method:(NSString *)method params:(id)params sessionManager:(AFHTTPSessionManager *)sessionManager {
	NSMutableURLRequest *request = [sessionManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:endpoint relativeToURL:sessionManager.baseURL] absoluteString] parameters:params error:nil];

	[request setValue:@"application/rss+xml" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/rss+xml" forHTTPHeaderField:@"Content-Type"];

	return request;
}

- (void)requestWithAbsolutePath:(NSString *)absolutePath method:(HNRequestHandlerMethod)method params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(HNError *error))failure {
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	[manager GET:absolutePath parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    if (success) {
	        success(responseObject);
		}
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    if (failure) {
	        failure([self createErrorModelFromResponse:nil error:error]);
		}
	}];
}

#pragma mark Private methods

- (NSString *)requestMethodString:(HNRequestHandlerMethod)method {
	switch (method) {
		case HNRequestMethodDELETE:
			return @"DELETE";
			break;

		case HNRequestMethodGET:
			return @"GET";
			break;

		case HNRequestMethodPOST:
			return @"POST";
			break;

		case HNRequestMethodPUT:
			return @"PUT";
			break;

		default:
			break;
	}
}

- (HNError *)createErrorModelFromResponse:(id)errorResponse error:(NSError *)error {
	HNError *customError = [HNError modelFromJSONDictionary:[self transformErrorJSON:errorResponse ? errorResponse:@{}]];
	customError.error = error;
	return customError;
}

- (NSDictionary *)transformErrorJSON:(NSDictionary *)dict {
	return @{
			   @"errorType" : [dict contains:@"status"],
			   @"message"   : [dict contains:@"message"],
	};
}

@end
