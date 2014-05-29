//
//  DetailViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "Utillities.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SelectUserViewController.h"
#import "PersistentStore.h"
#import "ServiceRequest.h"
#import "Account.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@property (weak, nonatomic) IBOutlet UITextField *accountName;
@property (weak, nonatomic) IBOutlet UITextField *passcode;

@property (strong, nonatomic) Account *param;

@end

@implementation LoginViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!(self.param = [PersistentStore accountDetails]))
    {
        self.param = [[Account alloc] init];
    }
    
    self.accountName.text = self.param.accountName;
    self.passcode.text = self.param.passcode;
    
    [self.accountName becomeFirstResponder];
}

-(void)registerNewUser
{
    RegisterViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [registerVC setPresentingController:self.presentingController];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.accountName]) {
        [self.passcode becomeFirstResponder];
    }else{
//        [textField resignFirstResponder];
        [self startLoginRequest];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return ([string length]==4);
}

-(void)startLoginRequest
{
    self.param.accountName = self.accountName.text;
    self.param.passcode = self.passcode.text;
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    [sr startLoginTaskWithParameters:self.param
                   completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
                       Account *acc = [Account AccountWithProperties:json];
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           [self handleResponse:acc];
                       });
                   }];
}

-(void)handleResponse:(Account *)accountInfo
{
    if ([accountInfo.id length]) {
        [(SelectUserViewController *)self.presentingController setAccountInfo:accountInfo];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *error = [Utillities alertViewWithTitle:@"Signin Error" message:@"Failed to login with the supplied credentials" delegate:nil
                     cancelButtonTitle:nil
                     otherButtonTitles:@"Ok",nil];
        [error show];
        [self.accountName becomeFirstResponder];
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
