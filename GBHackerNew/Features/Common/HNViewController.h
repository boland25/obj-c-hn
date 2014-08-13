//
//  HNViewController.h
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNError.h"

@interface HNViewController : UIViewController

- (void)showError:(HNError *)error;

- (void)showActivityIndicator;

- (void)hideActivityIndicator;

@end
