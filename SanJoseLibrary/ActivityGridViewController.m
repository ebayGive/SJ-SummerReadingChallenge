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
#import "ActivityCollection.h"
#import "ServiceRequest.h"
#import "ActivityGrids.h"
#import "ActivityGridCellDataCollection.h"
#import "ActivityGrid.h"

@interface ActivityGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) User *currentUser;
@property (strong, nonatomic) ActivityGrid *activityGrid;

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

@end
