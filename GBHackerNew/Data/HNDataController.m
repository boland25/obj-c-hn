//
//  HNDataController.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNDataController.h"
#import "HNNetworking.h"
#import "HNXMLParserDelegate.h"
#import "HNConstants.h"

@interface HNDataController ()

@property (nonatomic, strong) HNXMLParserDelegate *xmlParserDelegate;

@end

@implementation HNDataController

+ (instancetype)sharedData {
	static HNDataController *sharedData = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedData = [[HNDataController alloc] init];
	});

	return sharedData;
}

- (void)getFeeds:(void (^)(NSArray *))success failure:(void (^)(HNError *))failure {
	[HNNetworking requestWithEndpoint:HN_FEEDS method:HNRequestMethodGET params:nil success: ^(id responseObject) {
	    NSXMLParser *xmlParser = responseObject;
	    xmlParser.shouldProcessNamespaces = YES;
	    xmlParser.delegate = [self getXMLParserDelegate];
	    self.xmlParserDelegate.successBlock = success;
	    [xmlParser parse];
	} failure: ^(HNError *error) {
	    failure(error);
	}];
}

- (void)getComments:(NSString *)commentPath success:(void (^)(NSString *htmlString))success failure:(void (^)(HNError *error))failure {
	HNNetworking *networking = [HNNetworking new];
	[networking requestWithAbsolutePath:commentPath method:HNRequestMethodGET params:nil success: ^(id responseObject) {
	    if (success) {
	        success([[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
		}
	} failure:failure];
}

- (HNXMLParserDelegate *)getXMLParserDelegate {
	if (!self.xmlParserDelegate) {
		self.xmlParserDelegate = [HNXMLParserDelegate new];
	}
	return self.xmlParserDelegate;
}

@end
