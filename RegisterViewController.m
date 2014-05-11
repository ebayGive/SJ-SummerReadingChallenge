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
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.branchNames reloadAllComponents];
        });
    }];
}

- (void)submitAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
