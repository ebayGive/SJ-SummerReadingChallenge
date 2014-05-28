//
//  RegisterViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/8/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "RegisterViewController.h"
#import "ServiceRequest.h"
#import "Branches.h"
#import "Branch.h"
#import "Account.h"
#import "Utillities.h"
#import "SelectUserViewController.h"

@interface RegisterViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountName;
@property (weak, nonatomic) IBOutlet UITextField *passcode;
@property (weak, nonatomic) IBOutlet UITextField *emails;
@property (weak, nonatomic) IBOutlet UIPickerView *branchNames;

@property (strong, nonatomic) Branches *branches;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submitAction)];
    self.navigationItem.rightBarButtonItem = submit;

    ServiceRequest *sr = [ServiceRequest sharedRequest];
    [sr getBranchDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        self.branches = [[Branches alloc] branchesWithProperties:(NSArray *)json];
        
        if (response) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.branchNames reloadAllComponents];
            });
        }
        else
            [self.branchNames reloadAllComponents];
        
    }];
}

- (void)submitAction
{
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    Account *acc = [Account new];
    acc.accountName = self.accountName.text;
    acc.passcode = self.passcode.text;
    acc.emailAddress = self.emails.text;
    NSUInteger selection = [self.branchNames selectedRowInComponent:0];
    acc.branchId = ((Branch *)[self.branches.branches objectAtIndex:selection]).id;
    [sr startRegisterTaskWithParameters:acc completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        
        if (response) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (json) {
                    [self handleRegistrationCompleteWithData:json];
                } else {
                    [self handleRegistrationFailedWithError:error];
                }
            });
        }
        else
        {
            if (json) {
                [self handleRegistrationCompleteWithData:json];
            } else {
                [self handleRegistrationFailedWithError:error];
            }
        }
        
    }];
}

-(void)handleRegistrationCompleteWithData:(NSDictionary *)data
{
    Account *acc = [Account AccountWithProperties:data];
    [(SelectUserViewController *)self.presentingController setAccountInfo:acc];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)handleRegistrationFailedWithError:(NSError *)error
{
    UIAlertView *alert = [Utillities alertViewWithTitle:error.domain
                                                message:error.userInfo[@"message"]
                                               delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.accountName]) {
        [self.passcode becomeFirstResponder];
    }
    else if ([textField isEqual:self.passcode])
    {
        [self.emails becomeFirstResponder];
    }
    else if ([textField isEqual:self.emails])
    {
        [self.branchNames becomeFirstResponder];
        [textField resignFirstResponder];
    }
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.branches branches] count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Branch *b = [self.branches.branches objectAtIndex:row];
    return b.name;
}

@end
