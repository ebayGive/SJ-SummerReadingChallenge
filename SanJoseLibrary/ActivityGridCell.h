//
//  ActivityGridCell.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/11/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityGridCellContents;
@interface ActivityGridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)populateWithData:(ActivityGridCellContents *)activityCellData;
-(UIAlertView *)showActivityDescription;

@end
