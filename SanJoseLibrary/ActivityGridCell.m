//
//  ActivityGridCell.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/11/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityGridCell.h"
#import "ActivityGridCellContents.h"
#import "Utillities.h"
#import "Activity.h"

@interface ActivityGridCell ()
@property (nonatomic, weak) ActivityGridCellContents *activityCellData;
@property (nonatomic, weak) Activity *userActivity;
@end

@implementation ActivityGridCell

-(void)populateWithActivityData:(ActivityGridCellContents *)activityCellData userActivity:(Activity *)activity
{
    self.userActivity = activity;
    self.activityCellData = activityCellData;
}

- (void)showActivityDescription
{
    UIAlertView *alert = [Utillities alertViewWithTitle:@"Activity"
                           message:self.activityCellData.description
                          delegate:nil
                 cancelButtonTitle:@"Ok" otherButtonTitles:nil];

    [alert show];
}



@end
