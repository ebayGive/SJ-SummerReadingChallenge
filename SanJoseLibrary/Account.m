//
//  Account.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (id)AccountWithProperties:(NSDictionary *)properties {
    return [[self alloc] initWithJSONProperties:properties];
}

@end
