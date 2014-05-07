//
//  ActivityGridCollection.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityGridCollection.h"
#import "Activity.h"

@implementation ActivityGridCollection

+(NSString *)collectionType
{
    return NSStringFromClass([Activity class]);
}

@end
