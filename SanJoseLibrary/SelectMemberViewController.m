//
//  SelectMemberViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/30/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "SelectMemberViewController.h"
#import "NewMemberViewController.h"
#import "ActivityViewController.h"
#import "RegisterViewController.h"
#import "MemberCell.h"

#import "PersistentStore.h"

#import "ServiceRequest.h"
#import "UserTypes.h"
#import "User.h"
#import "Account.h"

@interface SelectMemberViewController ()

@property (strong, nonatomic) UserTypes *userTypes;
@property (strong, nonatomic) Account *accountInfo;

@end

@implementation SelectMemberViewController

-(void)setAccountInfo:(Account *)accountInfo
{
    _accountInfo = accountInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    [sr getUserTypesWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        self.userTypes = [[UserTypes alloc] userTypesWithProperties:(NSArray *)json];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    if ([PersistentStore accountDetails]) {
        [sr getUserAccountDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
            if (json != nil) {
                self.accountInfo = [Account AccountWithProperties:json];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                    if ([self.accountInfo.users count]==1) {
                        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                          animated:YES
                                                    scrollPosition:UICollectionViewScrollPositionNone];
                    }else if ([self.accountInfo.users count]==0) {
                        [self showAddMember];
                    }
                });
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

- (void)showLoginViewController
{
    UIViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [(RegisterViewController *)loginVC setPresentingController:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

- (void)showAddMember
{
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMemberNavigation"];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    NewMemberViewController * destVC = (NewMemberViewController *)[navController topViewController];
    [destVC setUserTypes:self.userTypes];
    [destVC setAccountInfo:self.accountInfo];
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MemberCell"
                                                                 forIndexPath:indexPath];
    User *user = [self.accountInfo.users objectAtIndex:indexPath.item];
    [cell setupCellWithUser:user andUserTypes:self.userTypes];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.accountInfo.users count];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewMemberViewController"]) {
        UINavigationController *nav = (UINavigationController *)[segue destinationViewController];
        NewMemberViewController * destVC = (NewMemberViewController *)[nav topViewController];
        [destVC setUserTypes:self.userTypes];
        [destVC setAccountInfo:self.accountInfo];
    }
    else if ([segue.identifier isEqualToString:@"RegisterViewController"])
    {
        [PersistentStore deleteAccount];
        UINavigationController *nav = (UINavigationController *)[segue destinationViewController];
        RegisterViewController * destVC = (RegisterViewController *)[nav topViewController];
        [destVC setPresentingController:self];
    }
    else if ([segue.identifier isEqualToString:@"ActivityViewController"])
    {
        NSInteger idx = [(NSIndexPath *)[[self.collectionView indexPathsForSelectedItems] firstObject] item];
        if (idx<[self.accountInfo.users count]) {
            User *object = [self.accountInfo.users objectAtIndex:idx];
            ActivityViewController * destVC = (ActivityViewController *)[segue destinationViewController];
            [destVC setCurrentUser:object];
        }
    }
}

@end
