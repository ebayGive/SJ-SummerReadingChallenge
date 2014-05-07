//
//  UserArray.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "UserCollection.h"
#import "User.h"

@implementation UserCollection

+(NSString *)collectionType
{
    return NSStringFromClass([User class]);
}

@end
