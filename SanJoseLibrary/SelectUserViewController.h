//
//  MasterViewController.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class LoginViewController;
@class Account;

@interface SelectUserViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Account *accountInfo;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
