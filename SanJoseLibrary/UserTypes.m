//
//  UserTypes.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "NSObject+JSONObject.h"
#import "UserTypes.h"
#import "UserType.h"

@implementation UserTypes

-(id)userTypesWithProperties:(NSArray *)properties
{
    id this = nil;
    if ((this=[self init])) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[properties count]];
        for (id obj in properties) {
            UserType *u = [[UserType alloc] initWithJSONProperties:obj];
            [arr addObject:u];
        }
        self.userTypes = [NSArray arrayWithArray:arr];
    }
    return this;
}

@end
