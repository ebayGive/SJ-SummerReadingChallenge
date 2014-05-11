//
//  User.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "User.h"

@implementation User

-(NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@",_firstName,_lastName];
}

@end
