//
//  HNError.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNModel.h"

@interface HNError : HNModel

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *errorType;
@property (nonatomic, strong) NSError *error;

@end
