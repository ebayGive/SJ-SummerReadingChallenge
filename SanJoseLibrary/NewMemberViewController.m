//
//  NewMemberViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/19/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "NewMemberViewController.h"
#import "UserTypes.h"
#import "UserType.h"
#import "ServiceRequest.h"
#import "User.h"
#import "Utillities.h"

@interface NewMemberViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UIPickerView *userType;

@end

@implementation NewMemberViewController

- (IBAction)dismissView:(UIButton *)sender {
    if (sender.tag == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        User *new = [User new];
        new.firstName = self.firstName.text;
        new.lastName = self.lastName.text;
        new.age = [self.age.text integerValue];
        NSInteger i = [self.userType selectedRowInComponent:0];
        new.userType = [[[self.userTypes userTypes] objectAtIndex:i] id];
        if ([new.firstName length] && [new.lastName length] && new.age && [self.userTypes.userTypes count]) {
            [[ServiceRequest sharedRequest] startAddUserTaskWithParameters:new completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }];
        }
        else
        {
            [Utillities showBasicInputError];
        }
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.userTypes userTypes] count]-1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    UserType *b = [self.userTypes.userTypes objectAtIndex:row];
    if ([b.name hasPrefix:@"STAFF"]) {
        b = [self.userTypes.userTypes objectAtIndex:row+1];
    }
    NSString *title = [NSString stringWithFormat:@"%@ (%@-%@)",b.name, b.minAge, b.maxAge];
    return title;
}

@end
