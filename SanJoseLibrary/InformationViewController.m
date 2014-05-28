//
//  InformationViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/9/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "InformationViewController.h"
#import "User.h"

@interface InformationViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) User *currentUser;

@end

@implementation InformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *pathForHTML = [[NSBundle mainBundle] pathForResource:@"help-android" ofType:@"html"];
    
    NSString *imagePath = [[NSBundle mainBundle] resourcePath];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"file:/%@//",imagePath]];
    
    NSData *htmlData = [[NSFileManager defaultManager] contentsAtPath:pathForHTML];
    
    [self.webView loadData:htmlData
                  MIMEType:@"text/html"
          textEncodingName:@"utf-8"
                   baseURL:baseURL];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}

@end
