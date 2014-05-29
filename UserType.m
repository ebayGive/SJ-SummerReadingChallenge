//
//  UserTypes.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "Utillities.h"
#import "UserType.h"

@implementation UserType

-(UIColor *)color
{
    UIColor *color = [UIColor whiteColor];
    if ([_name isEqualToString:@"READER"]) {
        color = UIColorFromRGB(0xD5453A);
//        color = [UIColor colorWithRed:(CGFloat)(213.0/255.0) green:(CGFloat)(132.0/255.0) blue:(CGFloat)(58.0/255.0) alpha:1.0f];
    }
    else if ([_name isEqualToString:@"PRE-READER"])
    {
        color = UIColorFromRGB(0xD08035);
//        color = [UIColor colorWithRed:(CGFloat)(213.0/255.0) green:(CGFloat)(69.0/255.0) blue:(CGFloat)(58.0/255.0) alpha:1.0f];
    }
    else if ([_name isEqualToString:@"TEEN"])
    {
        color = UIColorFromRGB(0x257782);
//        color = [UIColor colorWithRed:(CGFloat)(37.0/255.0) green:(CGFloat)(119.0/255.0) blue:(CGFloat)(130.0/255.0) alpha:1.0f];
    }
    else if ([_name isEqualToString:@"ADULT"])
    {
        color = UIColorFromRGB(0x2CA341);
//        color = [UIColor colorWithRed:(CGFloat)(44.0/255.0) green:(CGFloat)(43.0/255.0) blue:(CGFloat)(65.0/255.0) alpha:1.0f];
    }
    else if ([_name isEqualToString:@"STAFF SJPL"])
    {
        color = UIColorFromRGB(0x6D6E70);
//        color = [UIColor colorWithRed:(CGFloat)(109.0/255.0) green:(CGFloat)(110.0/255.0) blue:(CGFloat)(112.0/255.0) alpha:1.0f];
    }
    
    return color;
}

@end
