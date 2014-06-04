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
    if ([PersistentStore accountDetails]) {
        [sr getUserAccountDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
            if (json != nil) {
                self.accountInfo = [Account AccountWithProperties:json];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.collectionView reloadData];
                    [self autoNavigate];
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Select Member";
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}

-(void)didDismissLoginViewController
{
    [[ServiceRequest sharedRequest] getUserAccountDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        if (json != nil) {
            self.accountInfo = [Account AccountWithProperties:json];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                [self autoNavigate];
            });
        }
    }];
}

-(void)autoNavigate
{
    if ([self.accountInfo.users count]==1) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                          animated:YES
                                    scrollPosition:UICollectionViewScrollPositionNone];
        [self performSegueWithIdentifier:@"ActivityViewController" sender:nil];
    }else if ([self.accountInfo.users count]==0) {
        [self showAddMember];
    }
}

-(void)didAddNewMember
{
    [[ServiceRequest sharedRequest] getUserAccountDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        if (json != nil) {
            self.accountInfo = [Account AccountWithProperties:json];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                [self autoNavigate];
            });
        }
    }];
}

- (void)showLoginViewController
{
    [self performSegueWithIdentifier:@"RegisterViewController" sender:nil];
}

- (void)showAddMember
{
    [self performSegueWithIdentifier:@"NewMemberViewController" sender:nil];
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

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    BOOL shouldPerformSegue = NO;
    
    if ([identifier isEqualToString:@"NewMemberViewController"]) {
        shouldPerformSegue = self.userTypes&&self.accountInfo;
    }
    else if ([identifier isEqualToString:@"RegisterViewController"])
    {
        [PersistentStore deleteAccount];
        shouldPerformSegue = YES;
    }
    else if ([identifier isEqualToString:@"ActivityViewController"])
    {
        shouldPerformSegue = [self.accountInfo.users count]&&self.accountInfo.users;
    }
    
    return shouldPerformSegue;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewMemberViewController"]) {
        UINavigationController *nav = (UINavigationController *)[segue destinationViewController];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        
        NewMemberViewController * destVC = (NewMemberViewController *)[nav topViewController];
        [destVC setUserTypes:self.userTypes];
        [destVC setAccountInfo:self.accountInfo];
        [destVC setPresentingController:self];
    }
    else if ([segue.identifier isEqualToString:@"RegisterViewController"])
    {
        [PersistentStore deleteAccount];
        UINavigationController *nav = (UINavigationController *)[segue destinationViewController];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
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
