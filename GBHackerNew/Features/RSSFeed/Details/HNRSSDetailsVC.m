//
//  HNRSSDetailsVC.m
//  GBHackerNew
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Gregory Boland. All rights reserved.
//

#import "HNRSSDetailsVC.h"
#import "HNDataController.h"

@interface HNRSSDetailsVC () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *commentView;
@property (nonatomic, weak) IBOutlet UILabel *linkUrl;
@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *tapGesture;

@end

@implementation HNRSSDetailsVC


- (void)viewDidLoad {
	[super viewDidLoad];
	[self layoutDetails];
}

#pragma mark Private methods

- (void)layoutDetails {
	self.title = self.detailItem.title;
	[self setLinkLabel];
	[self setCommentsWithLink];
	[self.tapGesture addTarget:self action:@selector(handleOnLabelWasTapped:)];
}

- (void)setCommentsWithLink {
	[[HNDataController sharedData] getComments:self.detailItem.comments success: ^(NSString *htmlString) {
	    [self loadHTML:htmlString];
	} failure: ^(HNError *error) {
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

- (void)loadHTML:(NSString *)htmlString {
	[self.commentView loadHTMLString:htmlString baseURL:nil];
}

- (void)resizeHTMLViewToFit {
	CGSize contentSize = self.commentView.scrollView.contentSize;
	CGSize viewSize = self.view.bounds.size;

	float rw = viewSize.width / contentSize.width;

	self.commentView.scrollView.minimumZoomScale = rw;
	self.commentView.scrollView.maximumZoomScale = rw;
	self.commentView.scrollView.zoomScale = rw;
}

#pragma mark - UILabel Actions

- (void)handleOnLabelWasTapped:(UIGestureRecognizer *)gesture {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.detailItem.link]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	//TODO: css style could be applied here in a future release

	//NOTE: wasn't sure how to deal with the comments section as it doesn't fit without re-sizing it, this is a temp solution
	[self resizeHTMLViewToFit];
	[self hideActivityIndicator];
}

@end
