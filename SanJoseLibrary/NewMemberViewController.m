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

@interface NewMemberViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UIPickerView *userType;


@end

@implementation NewMemberViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissView:(UIButton *)sender {
    if (sender.tag == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        User *new = [User new];
        new.firstName = self.firstName.text;
        new.lastName = self.lastName.text;
        NSInteger i = [self.userType selectedRowInComponent:0];
        new.userType = [[[self.userTypes userTypes] objectAtIndex:i] id];
        [[ServiceRequest sharedRequest] startAddUserTaskWithParameters:new completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.userTypes userTypes] count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    UserType *b = [self.userTypes.userTypes objectAtIndex:row];
    return b.name;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
