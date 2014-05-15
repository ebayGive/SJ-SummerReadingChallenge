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

@interface ReadingLogViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) NSIndexPath *currentIndexPath;
@property (weak, nonatomic) User *currentUser;
@property (weak, nonatomic) IBOutlet UICollectionView *readingLogCollectionView;


@end

@implementation ReadingLogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentUser = [(ContainerViewController *)self.parentViewController currentUser];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.readingLogCollectionView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSInteger max = [self.currentUser.readingLog integerValue]/20;
    if (max>[self.readingLogCollectionView numberOfItemsInSection:0]) {
        max = [self.readingLogCollectionView numberOfItemsInSection:0];
    }
    
    self.currentIndexPath = [NSIndexPath indexPathForItem:max-1 inSection:0];
    [self updateCellAtIndexPath:self.currentIndexPath];
}

- (void)updateCellAtIndexPath:(NSIndexPath *)ip
{
    if (ip.item<0) {
        return;
    }
    [self.readingLogCollectionView performBatchUpdates:^{
        ReadingLogCell *cell = (ReadingLogCell *)[self.readingLogCollectionView cellForItemAtIndexPath:ip];
        NSString *imgName = nil;
        if ((ip.item+1)/10<1) {
            imgName = [NSString stringWithFormat:@"APP BATTERY ON-0%d",ip.item+1];
        } else {
            imgName = [NSString stringWithFormat:@"APP BATTERY ON-%d",ip.item+1];
        }
        [cell.imageView setImage:[UIImage imageNamed:imgName]];
    } completion:^(BOOL finished) {
        self.currentIndexPath = [NSIndexPath indexPathForItem:ip.item-1 inSection:ip.section];
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
    ReadingLogCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"readingLogCell"
                                                                           forIndexPath:indexPath];
    NSString *imgName = nil;
    if ((indexPath.item+1)/10<1) {
        imgName = [NSString stringWithFormat:@"APP BATTERY OFF-0%d",indexPath.item+1];
    } else {
        imgName = [NSString stringWithFormat:@"APP BATTERY OFF-%d",indexPath.item+1];
    }
    [cell.imageView setImage:[UIImage imageNamed:imgName]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = [NSIndexPath indexPathForItem:_currentIndexPath.item-1
                                                inSection:_currentIndexPath.section];
    [self updateCellAtIndexPath:self.currentIndexPath];
}

@end
