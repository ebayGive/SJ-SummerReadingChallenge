//
//  PrizeTypes.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/20/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "PrizeTypes.h"
#import "PrizeType.h"
#import "NSObject+JSONObject.h"

@implementation PrizeTypes

-(id)prizeTypesWithProperties:(NSArray *)properties
{
    id this = nil;
    if ((this=[self init])) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[properties count]];
        for (id obj in properties) {
            PrizeType *p = [[PrizeType alloc] initWithJSONProperties:obj];
            [arr addObject:p];
        }
        self.prizeTypes = [NSArray arrayWithArray:arr];
    }
    return this;
}

-(PrizeType *)prizesForUserType:(NSString *)userType
{
    for (PrizeType *p in self.prizeTypes) {
        if ([userType isEqualToString:p.userType]) {
            return p;
        }
    }
    return nil;
}

@end
