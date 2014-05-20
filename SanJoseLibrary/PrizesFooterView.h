//
//  PrizesFooterView.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/20/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrizeType;
@interface PrizesFooterView : UICollectionReusableView

-(void)setupViewWithPrizeType:(PrizeType *)prizeType;

@end
