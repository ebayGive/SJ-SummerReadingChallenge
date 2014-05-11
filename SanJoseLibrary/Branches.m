//
//  Branches.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/8/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "Branches.h"
#import "Branch.h"
#import "NSObject+JSONObject.h"

@implementation Branches

- (id)branchesWithProperties:(NSArray *)properties {
    id this = nil;
    if ((this=[self init])) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[properties count]];
        for (id obj in properties) {
            Branch *b = [[Branch alloc] initWithJSONProperties:obj];
            [arr addObject:b];
        }
        self.branches = [NSArray arrayWithArray:arr];
    }
    return this;
}

@end
