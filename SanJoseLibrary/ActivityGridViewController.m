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
#import "Prize.h"
#import "NSObject+JSONObject.h"

@interface ActivityGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ActivityGridCellDelegate>

@property (weak, nonatomic) User *currentUser;
@property (strong, nonatomic) ActivityGrid *activityGrid;
@property (strong, nonatomic) PrizeType *prizesForUser;

@property (weak, nonatomic) IBOutlet UICollectionView *activityGridCollectionView;


@end

@implementation ActivityGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.activityGridCollectionView registerClass:[UICollectionReusableView class]
                        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                               withReuseIdentifier:@"HeaderView"];

    self.currentUser = [(ContainerViewController *)self.parentViewController currentUser];
    
    ServiceRequest *sr = [ServiceRequest sharedRequest];
    [sr getGridDetailsWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        ActivityGrids *ag = [[ActivityGrids alloc] activityGridsWithProperties:(NSArray *)json[@"grids"]];
        self.activityGrid = [ag activityGridForUserId:self.currentUser.userType];
        if (response) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.activityGridCollectionView reloadData];
            });
        }
        else
            [self.activityGridCollectionView reloadData];
        
    }];
    
    [sr getPrizeAndUserTypesWithCompletionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
        PrizeTypes *prizes = [[PrizeTypes alloc] prizeTypesWithProperties:json[@"prizes"]];
        self.prizesForUser = [prizes prizesForUserType:self.currentUser.userType];
        if (response) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.activityGridCollectionView reloadData];
            });
        }
        else
            [self.activityGridCollectionView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.activityGridCollectionView reloadData];
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
    cell.delegate = self;
    [cell showActivityDescription];
}

-(void)activityGridCell:(ActivityGridCell *)activityGridCell didSelectItemWithAction:(UserActivityAction)userActivityAction cellIndex:(NSString *)cellIndex userActivityInfo:(Activity *)userActivityInfo
{

    [[ServiceRequest sharedRequest] updateAvtivityForUserID:self.currentUser.id
                                               userActivity:userActivityInfo
                                                  cellIndex:cellIndex
                                          completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
                                              NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[json[@"prizes"] count]];
                                              for (id obj in json[@"prizes"]) {
                                                  Prize *p = [[Prize alloc] initWithJSONProperties:obj];
                                                  [arr addObject:p];
                                              }
                                              BOOL prizesViewNeedsRefresh = NO;
                                              if (![[arr valueForKeyPath:@"state"] isEqualToArray:[self.currentUser.prizes valueForKeyPath:@"state"]])
                                              {
                                                  prizesViewNeedsRefresh = YES;
                                                  self.currentUser.prizes = [arr copy];
                                              }
                                              
                                              [arr removeLastObject];
                                              NSIndexPath *ip = [NSIndexPath indexPathForItem:[cellIndex integerValue] inSection:0];
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  
                                                  [self.currentUser updateActivity:userActivityInfo atIndex:[cellIndex integerValue]];
                                                  
                                                  if (prizesViewNeedsRefresh)
                                                      [self.activityGridCollectionView reloadData];
                                                  else
                                                      [self.activityGridCollectionView reloadItemsAtIndexPaths:@[ip]];
                                                  
                                              });
                                          }];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        CGRect frame = reusableview.frame;
        frame.origin.x = 5;
        frame.size.width = CGRectGetWidth(reusableview.frame)-10;
        UILabel *header = [[UILabel alloc] initWithFrame:frame];
        [header setLineBreakMode:NSLineBreakByWordWrapping];
        [header setNumberOfLines:0];
        [header setText:@"Complete any 5 squares in a row to win prizes."];
        [reusableview addSubview:header];
        return reusableview;
    }
    else if (kind == UICollectionElementKindSectionFooter) {
        PrizesFooterView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PrizesFooterView" forIndexPath:indexPath];
        [reusableview setupViewWithPrizeType:self.prizesForUser userPrizeStatus:self.currentUser.prizes];
        return reusableview;
    }
    return nil;
}

@end
