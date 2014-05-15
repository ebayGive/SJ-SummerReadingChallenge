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

@interface ActivityGridCell ()
@property (nonatomic, weak) ActivityGridCellContents *activityCellData;
@end

@implementation ActivityGridCell

-(void)populateWithData:(ActivityGridCellContents *)activityCellData
{
    self.activityCellData = activityCellData;
}

- (UIAlertView *)showActivityDescription
{
    return [Utillities alertViewWithTitle:@"Activity"
                           message:self.activityCellData.description
                          delegate:nil
                 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
}

@end
