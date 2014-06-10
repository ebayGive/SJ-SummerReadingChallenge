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
            if (![u.name hasPrefix:@"STAFF"]) { //we dont need to show this usertype to the users.
                [arr addObject:u];
            }
        }
        self.userTypes = [NSArray arrayWithArray:arr];
    }
    return this;
}

-(UIColor *)colorForUserType:(NSString *)userType
{
    for (UserType *u in self.userTypes) {
        if ([userType isEqualToString:u.id]) {
            return [u color];
        }
    }
    return [UIColor blackColor];
}

-(NSString *)nameForUserType:(NSString *)userType
{
    for (UserType *u in self.userTypes) {
        if ([userType isEqualToString:u.id]) {
            return [u name];
        }
    }
    return nil;
}

@end
