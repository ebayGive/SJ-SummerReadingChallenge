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

@interface ActivityGridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)populateWithActivityData:(ActivityGridCellContents *)activityCellData
                   userActivity:(Activity *)activity;
-(void)showActivityDescription;

@end
