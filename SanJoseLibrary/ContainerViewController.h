//
//  ContainerViewController.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/9/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@interface ContainerViewController : UIViewController

@property (strong, nonatomic) User *currentUser;

- (void)swapSegueWithIdentifier:(NSString *)segueIdentifier;

@end
