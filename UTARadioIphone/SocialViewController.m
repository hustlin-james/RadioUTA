//
//  SocialViewController.m
//  radiouta
//
//  Created by James Fielder on 6/4/14.
//  Copyright (c) 2014 com.mobi. All rights reserved.
//

#import "SocialViewController.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Social";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)facebookbtnTap:(id)sender {
    NSString *urlStr = @"https://www.facebook.com/pages/UTA-Radio/152279484783168";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (IBAction)twitterbtnTap:(id)sender {
    NSString *urlStr = @"https://twitter.com/UTARadio";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return NO;
}

@end
