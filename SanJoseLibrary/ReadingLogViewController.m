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
    [self.readingLogCollectionView performBatchUpdates:^{
        NSInteger max = [self.currentUser.readingLog integerValue]/20;
        if (max>[self.readingLogCollectionView numberOfItemsInSection:0]) {
            max = [self.readingLogCollectionView numberOfItemsInSection:0];
        }
        for (int i=max-1; i>=0; i--) {
            NSIndexPath *ip = [NSIndexPath indexPathForItem:i inSection:0];
            ReadingLogCell *cell = (ReadingLogCell *)[self.readingLogCollectionView cellForItemAtIndexPath:ip];
            [cell setBackgroundColor:[UIColor greenColor]];
        }
    } completion:^(BOOL finished) {
        
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
    return cell;
}

@end
