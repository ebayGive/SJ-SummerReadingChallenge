//
//  MemberCell.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/30/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class UserTypes;

@interface MemberCell : UICollectionViewCell

-(void)setupCellWithUser:(User *)user andUserTypes:(UserTypes *)types;

@end
