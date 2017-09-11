//
//  ViewController.m
//  WebViewAdSample
//
//  Created by nend.net on 2017/09/12.
//  Copyright (c) 2017年 F@N Communications, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic) UIWebView* nendWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 広告用 WebView を配置する
    self.nendWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.nendWebView.delegate = self;
    self.nendWebView.center = self.view.center;
    
    // 背景色を透明にする
    self.nendWebView.opaque = NO;
    self.nendWebView.backgroundColor = [UIColor clearColor];
    
    // ローカルの html を読み込む
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"nendAd"ofType:@"html"]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.nendWebView loadRequest:req];
    
    [self.view addSubview:self.nendWebView];
}

- (void)dealloc {
    if (self.nendWebView.loading) {
        [self.nendWebView stopLoading];
    }
    self.nendWebView.delegate = nil;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    if( navigationType == UIWebViewNavigationTypeLinkClicked ){
        // UIWebViewNavigationTypeLinkClicked
        if( [[UIApplication sharedApplication] canOpenURL:request.URL]){
            // Browser open.
            [[UIApplication sharedApplication] openURL:request.URL];
            return NO;
        }
    }
    return YES;
}

@end
