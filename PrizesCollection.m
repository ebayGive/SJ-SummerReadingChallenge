//
//  PrizesCollection.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "PrizesCollection.h"
#import "Prize.h"

@implementation PrizesCollection

+(NSString *)collectionType
{
    return NSStringFromClass([Prize class]);
}

@end
