//
//  SelectMemberViewController.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/30/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Account;
@interface SelectMemberViewController : UICollectionViewController

-(void)setAccountInfo:(Account *)accountInfo;
-(void)didDismissLoginViewController;
-(void)didAddNewMember;
@end
