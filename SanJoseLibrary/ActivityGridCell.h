//
//  ActivityGridCell.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/11/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Activity;
@class ActivityGridCellContents;
@protocol ActivityGridCellDelegate;

typedef enum : NSUInteger {
    ActivityCompleted,
    ActivityDelayed,
} UserActivityAction;

@interface ActivityGridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) id<ActivityGridCellDelegate> delegate;

-(void)populateWithActivityData:(ActivityGridCellContents *)activityCellData
                   userActivity:(Activity *)activity;
-(void)showActivityDescription;

@end

@protocol ActivityGridCellDelegate <UICollectionViewDelegate>

-(void)activityGridCell:(ActivityGridCell *)activityGridCell
didSelectItemWithAction:(UserActivityAction)userActivityAction
              cellIndex:(NSString *)cellIndex
       userActivityInfo:(Activity *)userActivityInfo;

@end
