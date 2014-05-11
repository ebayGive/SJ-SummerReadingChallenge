//
//  UserArray.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "UserCollection.h"

@implementation UserCollection

+(Class)collectionType
{
    return [User class];
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
