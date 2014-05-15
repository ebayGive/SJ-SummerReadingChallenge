//
//  ActivityGridCellDataCollection.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityGridCellDataCollection.h"

@implementation ActivityGridCellDataCollection

+(Class)collectionType
{
    return [ActivityGridCellContents class];
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
