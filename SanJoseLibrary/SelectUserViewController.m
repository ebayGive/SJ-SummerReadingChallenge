//
//  MasterViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "SelectUserViewController.h"
#import "LoginViewController.h"
#import "Account.h"
#import "ActivityViewController.h"
#import "NewMemberViewController.h"
#import "ServiceRequest.h"
#import "UserTypes.h"
#import "User.h"
#import "PersistentStore.h"

@interface SelectUserViewController ()

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) UserTypes *userTypes;

@end

@implementation SelectUserViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Select Member";
    
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    [sr getUserTypesWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        self.userTypes = [[UserTypes alloc] userTypesWithProperties:(NSArray *)json];
    }];
    
    self.tableView.tableFooterView = [UIView new];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    if ([PersistentStore accountDetails]) {
        [sr getUserAccountDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
            if (json != nil) {
                self.accountInfo = [Account AccountWithProperties:json];
            }
        }];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLoginViewController];
        });
    }
    self.title = @"Select Member";
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    if ([self.accountInfo.users count]==1) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

- (IBAction)logout:(UIBarButtonItem *)sender {
    [PersistentStore deleteAccount];
    [self showLoginViewController];
}

- (void)showLoginViewController
{
    UIViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [(LoginViewController *)loginVC setPresentingController:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.accountInfo.users count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"";
    if (indexPath.row<[tableView numberOfRowsInSection:indexPath.section]-1) {
        cellId = @"Cell";
    }
    else
    {
        cellId = @"newMember";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger idx = [self.tableView indexPathForSelectedRow].row;
    if (idx<[self.accountInfo.users count]) {
        User *object = [self.accountInfo.users objectAtIndex:idx];
        ActivityViewController * destVC = (ActivityViewController *)[segue destinationViewController];
        [destVC setCurrentUser:object];
    } else {
        NewMemberViewController * destVC = (NewMemberViewController *)[(UINavigationController *)[segue destinationViewController] topViewController];
        [destVC setUserTypes:self.userTypes];
        [destVC setAccountInfo:self.accountInfo];
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<[self.accountInfo.users count]) {
        User *name = [self.accountInfo.users objectAtIndex:indexPath.row];
        cell.textLabel.text = [name fullName];
        [cell setBackgroundColor:[self.userTypes colorForUserType:name.userType]];
        cell.imageView.image = [UIImage imageNamed:[self.userTypes nameForUserType:name.userType]];
    }
    else
    {
        cell.textLabel.text = @"Add Family Member";
    }
}

@end
