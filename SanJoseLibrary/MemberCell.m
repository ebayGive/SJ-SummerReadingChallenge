//
//  MemberCell.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/30/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "MemberCell.h"
#import "User.h"
#import "UserTypes.h"

@interface MemberCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) User *user;
@property (weak, nonatomic) UserTypes *userTypes;

@end

@implementation MemberCell

-(void)awakeFromNib
{
    
}

-(void)setupCellWithUser:(User *)user andUserTypes:(UserTypes *)types
{
    self.user = user;
    self.userTypes = types;
    self.userName.text = [user fullName];
    [self setBackgroundColor:[types colorForUserType:user.userType]];
    self.userTypeImageView.image = [UIImage imageNamed:[types nameForUserType:user.userType]];
}

@end
