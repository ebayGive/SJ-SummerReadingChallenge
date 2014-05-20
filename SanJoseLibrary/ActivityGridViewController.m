//
//  ActivityGridViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/9/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityGridViewController.h"
#import "ContainerViewController.h"
#import "User.h"
#import "ActivityGridCell.h"
#import "ServiceRequest.h"
#import "ActivityGrids.h"
#import "ActivityGrid.h"
#import "PrizesFooterView.h"
#import "PrizeType.h"
#import "PrizeTypes.h"

@interface ActivityGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) User *currentUser;
@property (strong, nonatomic) ActivityGrid *activityGrid;
@property (strong, nonatomic) PrizeType *prizesForUser;

@property (weak, nonatomic) IBOutlet UICollectionView *activityGridCollectionView;


@end

@implementation ActivityGridViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentUser = [(ContainerViewController *)self.parentViewController currentUser];
    
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    [sr getGridDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        ActivityGrids *ag = [[ActivityGrids alloc] activityGridsWithProperties:(NSArray *)json[@"grids"]];
        self.activityGrid = [ag activityGridForUserId:self.currentUser.userType];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.activityGridCollectionView reloadData];
        });
    }];
    [sr getPrizeAndUserTypesWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        PrizeTypes *prizes = [[PrizeTypes alloc] prizeTypesWithProperties:json[@"prizes"]];
        self.prizesForUser = [prizes prizesForUserType:self.currentUser.userType];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.activityGridCollectionView reloadData];
        });
    }];
    
    [self.activityGridCollectionView registerClass:[UICollectionReusableView class]
                        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                               withReuseIdentifier:@"HeaderView"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.activityGridCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.activityGrid.cells count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"activityGridCell"
                                                                           forIndexPath:indexPath];
    ActivityGridCellContents *data = [self.activityGrid.cells objectAtIndex:indexPath.item];
    Activity *userActivity = [self.currentUser.activityGrid objectAtIndex:indexPath.item];
    [cell populateWithActivityData:data userActivity:userActivity];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityGridCell *cell = (ActivityGridCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell showActivityDescription];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 42)];
        [header setLineBreakMode:NSLineBreakByWordWrapping];
        [header setNumberOfLines:0];
        [header setText:@"Complete 5 squares in a row to win prizes"];
        [reusableview addSubview:header];
        return reusableview;
    }
    else if (kind == UICollectionElementKindSectionFooter) {
        PrizesFooterView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PrizesFooterView" forIndexPath:indexPath];
        [reusableview setupViewWithPrizeType:self.prizesForUser];
        return reusableview;
    }
    return nil;
}

@end
