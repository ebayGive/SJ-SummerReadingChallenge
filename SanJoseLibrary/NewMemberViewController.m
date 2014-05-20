//
//  NewMemberViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/19/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "NewMemberViewController.h"

@interface NewMemberViewController ()

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

- (IBAction)dismissView:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
