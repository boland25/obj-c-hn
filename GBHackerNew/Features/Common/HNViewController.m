//
//  HNViewController.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNViewController.h"
//#import <SVProgressHUD/SVProgressHUD.h>

@implementation HNViewController

- (void)showError:(HNError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

- (void)showActivityIndicator
{
  //  [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void)hideActivityIndicator
{
   // [SVProgressHUD dismiss];
}

@end
