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
    if ([self.activityCellData.gridIcon isEqualToString:@"ROBOT"]) {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"switchToChargeBatteryViewController" object:nil]];
        return;
    }

    UIAlertView *alert = [Utillities alertViewWithTitle:@"Activity"
                           message:self.activityCellData.description
                          delegate:self
                 cancelButtonTitle:@"I'll do it later" otherButtonTitles:@"I did it",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = self.userActivity.notes;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter activity notes (optional)"];
    [alert show];
}

- (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    return dateFormatter;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UserActivityAction action;
    if (buttonIndex == [alertView cancelButtonIndex]) {
        action = ActivityDelayed;
        self.userActivity.activity = NO;
    }
    else
    {
        self.userActivity.activity = YES;
        action = ActivityCompleted;
    }
    self.userActivity.notes = [[alertView textFieldAtIndex:0] text];
    self.userActivity.updatedAt = [[self dateFormatter] stringFromDate:[NSDate date]];
    [self.delegate activityGridCell:self
            didSelectItemWithAction:action
                          cellIndex:self.activityCellData.index
                   userActivityInfo:self.userActivity];
}

@end
