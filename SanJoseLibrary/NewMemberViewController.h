//
//  NewMemberViewController.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/19/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Account;
@class UserTypes;
@class SelectMemberViewController;

@interface NewMemberViewController : UITableViewController

@property(nonatomic,strong) SelectMemberViewController *presentingController;
@property (strong, nonatomic) Account *accountInfo;
@property (strong, nonatomic) UserTypes *userTypes;

@end
