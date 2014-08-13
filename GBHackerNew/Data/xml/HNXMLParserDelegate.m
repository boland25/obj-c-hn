//
//  HNXMLParserDelegate.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNXMLParserDelegate.h"

@interface HNXMLParserDelegate ()

@property (nonatomic, strong) NSMutableDictionary *xmlDict;
@property (nonatomic, strong) NSMutableArray *storageArray;
//
@property (nonatomic, strong) NSMutableString *elementString;
@property (nonatomic, copy) NSString *elementName;
@property (nonatomic, strong) NSMutableDictionary *elementDict;

@end

@implementation HNXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	self.xmlDict = [NSMutableDictionary dictionary];
    self.storageArray = [NSMutableArray array];
    self.xmlDict[@"items"] = self.storageArray;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	self.successBlock(self.storageArray);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	self.elementName = qName;

	if ([self.elementName isEqualToString:@"item"]) {
		self.elementDict = [NSMutableDictionary dictionary];
	}
	self.elementString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!self.elementName) {
		return;
	}
	//NSLog(@"Found these chars %@", string);

	[self.elementString appendFormat:@"%@", string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([qName isEqualToString:@"item"]) {
		//this is the container for the json so put it in the array
		[self.storageArray addObject:self.elementDict];
	}
	else if ([qName isEqualToString:@"channel"] || [qName isEqualToString:@"rss"]) {
		//hmm end of the channel which means end of the line so what do i do here?
	}
	else {
		//NOTE:if the xml crawler is inside an item node it will place the stuff in this dict
		if (self.elementDict) {
			self.elementDict[self.elementName] = self.elementString;
		}
		else {
			self.xmlDict[self.elementName] = self.elementString;
		}
	}
	self.elementName = nil;
}

@end
