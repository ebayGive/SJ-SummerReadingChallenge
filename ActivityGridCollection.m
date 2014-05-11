//
//  ActivityGridCollection.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityGridCollection.h"

@implementation ActivityGridCollection

+(Class)collectionType
{
    return [Activity class];
}

-(id)collectionContainer
{
    return self.container;
}

-(void)setCollectionContainer:(id)val
{
    self.container = [[NSArray alloc] initWithArray:val];
}

@end
