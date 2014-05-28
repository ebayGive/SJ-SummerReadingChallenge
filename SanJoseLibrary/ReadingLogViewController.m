//
//  ReadingLogViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/9/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ReadingLogViewController.h"
#import "ContainerViewController.h"
#import "User.h"
#import "ReadingLogCell.h"
#import "ServiceRequest.h"

@interface ReadingLogViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSArray *readingLogCollectionViewCells;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (weak, nonatomic) User *currentUser;
@property (weak, nonatomic) IBOutlet UICollectionView *readingLogCollectionView;


@end

@implementation ReadingLogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentUser = [(ContainerViewController *)self.parentViewController currentUser];
    
    NSMutableArray *cells = [[NSMutableArray alloc] initWithCapacity:23];
    for (int i =0; i<[self.readingLogCollectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForItem:i inSection:0];
        ReadingLogCell *cell = [self.readingLogCollectionView dequeueReusableCellWithReuseIdentifier:@"readingLogCell"
                                                                                        forIndexPath:ip];
        NSString *imgName = nil;
        if ((ip.item+1)/10<1) {
            imgName = [NSString stringWithFormat:@"APP BATTERY OFF-0%d",ip.item+1];
        } else {
            imgName = [NSString stringWithFormat:@"APP BATTERY OFF-%d",ip.item+1];
        }
        [cell.imageView setImage:[UIImage imageNamed:imgName]];
        [cells addObject:cell];
    }
    
    self.readingLogCollectionViewCells = [cells copy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 32, 32)];
    [btn setImage:[UIImage imageNamed:@"battery-charging"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(updateReadingLog:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chargeBattery = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UINavigationItem *navItem = self.parentViewController.parentViewController.navigationItem;
    [navItem setRightBarButtonItem:chargeBattery animated:YES];

    [self.readingLogCollectionView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UINavigationItem *navItem = self.parentViewController.parentViewController.navigationItem;
    [navItem setRightBarButtonItem:nil animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSInteger max = [self.currentUser.readingLog integerValue]/20;
    if (max>0) {
        [self updateCellAtIndexPath:self.currentIndexPath];
    }
}

-(NSIndexPath *)currentIndexPath
{
    if (!_currentIndexPath) {
        self.currentIndexPath = [NSIndexPath indexPathForItem:[self.readingLogCollectionViewCells count]-1
                                                    inSection:0];
    }
    return _currentIndexPath;
}

-(void)updateIndexPath
{
    NSUInteger idx = self.currentIndexPath.item;
    self.currentIndexPath = [NSIndexPath indexPathForItem:idx-1 inSection:self.currentIndexPath.section];
}

-(void)updateReadingLog:(UIBarButtonItem *)sender
{
    UIActionSheet *updateReadingLogConfirmation = [[UIActionSheet alloc] initWithTitle:@"Challenge yourself to read at least 20 minutes a day"
                                                                              delegate:self
                                                                     cancelButtonTitle:@"I dint read for 20 minutes"
                                                                destructiveButtonTitle:@"I read for 20 minutes"
                                                                     otherButtonTitles:nil];
    UINavigationItem *navItem = self.parentViewController.parentViewController.navigationItem;
    [updateReadingLogConfirmation showFromBarButtonItem:navItem.rightBarButtonItem animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        [self.currentUser incrementReadingLog];
        [[ServiceRequest sharedRequest] updateReadingLogForUser:self.currentUser
                                              completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
                                                  dispatch_sync(dispatch_get_main_queue(), ^{
                                                      [self updateCellAtIndexPath:self.currentIndexPath];
                                                  });
                                              }];
    }
}

- (void)updateCellAtIndexPath:(NSIndexPath *)ip
{
    NSInteger max = ([self.readingLogCollectionViewCells count]-1)-([self.currentUser.readingLog integerValue]/20);
    if (ip.item<=max) return;
    
    [self.readingLogCollectionView performBatchUpdates:^{
        ReadingLogCell *cell = [self.readingLogCollectionViewCells objectAtIndex:ip.item];
        NSString *imgName = nil;
        if ((ip.item+1)/10<1) {
            imgName = [NSString stringWithFormat:@"APP BATTERY ON-0%d",ip.item+1];
        } else {
            imgName = [NSString stringWithFormat:@"APP BATTERY ON-%d",ip.item+1];
        }
        [cell.imageView setImage:[UIImage imageNamed:imgName]];
    } completion:^(BOOL finished) {
        [self updateIndexPath];
        [self updateCellAtIndexPath:self.currentIndexPath];
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 45;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReadingLogCell *cell = [self.readingLogCollectionViewCells objectAtIndex:indexPath.item];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateReadingLog:nil];
}

@end
