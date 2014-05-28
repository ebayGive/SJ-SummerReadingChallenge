//
//  Prize.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "Prize.h"

@implementation Prize

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeBool:self.state forKey:@"state" ];
    [encoder encodeObject:self.notes
                   forKey:@"notes"];
    [encoder encodeObject:self.updatedAt
                   forKey:@"updatedAt"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        self.notes = [decoder decodeObjectForKey:@"notes"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
        self.state = [decoder decodeBoolForKey:@"state"];
    }
    return self;
}

@end
