//
//  HNRSSDetailsVC.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNRSSDetailsVC.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFUrlResponseSerialization.h"

@interface HNRSSDetailsVC () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *commentView;
@property (nonatomic, weak) IBOutlet UILabel *linkUrl;
@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *tapGesture;

@end

@implementation HNRSSDetailsVC


- (void)viewDidLoad {
	[super viewDidLoad];
	[self layoutDetails];

	// Do any additional setup after loading the view.
}

#pragma mark Private methods

- (void)layoutDetails {
	self.title = self.detailItem.title;
	[self setLinkLabel];
	[self setCommentsWithLink];
	[self.tapGesture addTarget:self action:@selector(handleOnLabelWasTapped:)];
}

- (void)setCommentsWithLink {
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	[manager GET:self.detailItem.comments parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
	    [self.commentView loadHTMLString:htmlString baseURL:nil];
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    // Fail silently
	    [self hideActivityIndicator];
	}];
	[self showActivityIndicator];
}

- (void)setLinkLabel {
	self.linkUrl.attributedText = [self addLinkToTitle:self.detailItem.link];
}

- (NSAttributedString *)addLinkToTitle:(NSString *)text {
	NSError *error = nil;
	NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
	NSArray *matches = [detector matchesInString:text
	                                     options:0
	                                       range:NSMakeRange(0, [text length])];
	NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
	for (NSTextCheckingResult *match in matches) {
		if ([match URL]) {
			[attString addAttributes:@{ NSLinkAttributeName:self.detailItem.link, NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) } range:match.range];
		}
	}
	return attString;
}

- (void)handleOnLabelWasTapped:(UIGestureRecognizer *)gesture {
	NSLog(@"gesture is tapped");
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.detailItem.link]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	//TODO: css style could be applied here in a future release
	[self hideActivityIndicator];
}

@end
