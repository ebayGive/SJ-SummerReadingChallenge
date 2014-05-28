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

@interface ActivityGridCell () <UIAlertViewDelegate>
@property (nonatomic, weak) ActivityGridCellContents *activityCellData;
@property (nonatomic, weak) Activity *userActivity;
@end

@implementation ActivityGridCell

-(void)populateWithActivityData:(ActivityGridCellContents *)activityCellData userActivity:(Activity *)activity
{
    self.userActivity = activity;
    self.activityCellData = activityCellData;
    
    NSString *img = [NSString stringWithFormat:@"GRID_%@_%d",activityCellData.gridIcon,activity.activity];
    img = [img stringByAppendingPathExtension:@"jpg"];
    [self.imageView setImage:[UIImage imageNamed:img]];
}

- (void)showActivityDescription
{
    UIAlertView *alert = [Utillities alertViewWithTitle:@"Activity"
                           message:self.activityCellData.description
                          delegate:self
                 cancelButtonTitle:@"Do it later" otherButtonTitles:@"Did it",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;

    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        
    }
    else
    {
        
    }
}

@end
