//
//  HNXMLParserDelegate.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HNXMLCompleteSuccessBlock)(NSArray *successArray);

@interface HNXMLParserDelegate : NSObject <NSXMLParserDelegate>

@property (nonatomic, copy) HNXMLCompleteSuccessBlock successBlock;

@end
