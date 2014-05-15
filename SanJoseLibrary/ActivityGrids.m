//
//  ActivityGridCollection.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityGrids.h"
#import "NSObject+JSONObject.h"
#import "ActivityGrid.h"

@implementation ActivityGrids

-(id)activityGridsWithProperties:(NSArray *)properties
{
    id this = nil;
    if ((this=[self init])) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[properties count]];
        for (id obj in properties) {
            ActivityGrid *b = [[ActivityGrid alloc] initWithJSONProperties:obj];
            [arr addObject:b];
        }
        self.activityGrids = [NSArray arrayWithArray:arr];
    }
    return this;
}

-(ActivityGrid *)activityGridForUserId:(NSString *)userId
{
    ActivityGrid *returnVal = nil;
    
    for (ActivityGrid *ag in self.activityGrids) {
        if ([ag.userType isEqualToString:userId]) {
            returnVal = ag;
            break;
        }
    }
    return returnVal;
}

@end
