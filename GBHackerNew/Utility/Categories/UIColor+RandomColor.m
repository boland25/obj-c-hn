//
//  UIColor+RandomColor.m
//  GBHackerNew
//
//  Created by boland on 8/12/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor {
	CGFloat hue = (arc4random() % 256 / 256.0);    //  0.0 to 1.0
	CGFloat saturation = (arc4random() % 128 / 128.0) + 0.7;    //  0.5 to 1.0, away from white
	CGFloat brightness = (arc4random() % 128 / 256.0) + 0.4;    //  0.5 to 1.0, away from black
	return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.8];
}

@end
