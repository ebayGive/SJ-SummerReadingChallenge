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

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.id
                   forKey:@"id"];
    [encoder encodeObject:self.accountName
                   forKey:@"accountName"];
    [encoder encodeObject:self.branchId
                   forKey:@"branchId"];
    [encoder encodeObject:self.emailAddress
                   forKey:@"emailAddress"];
    [encoder encodeObject:self.passcode
                   forKey:@"passcode"];
    [encoder encodeObject:self.role
                   forKey:@"role"];
    [encoder encodeObject:self.salt
                   forKey:@"salt"];
    [encoder encodeObject:self.type
                   forKey:@"type"];
    [encoder encodeObject:self.createdAt
                   forKey:@"createdAt"];
    [encoder encodeObject:self.updatedAt
                   forKey:@"updatedAt"];
    [encoder encodeObject:self.authToken
                   forKey:@"authToken"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        self.id = [decoder decodeObjectForKey:@"id"];
        self.accountName = [decoder decodeObjectForKey:@"accountName"];
        self.branchId = [decoder decodeObjectForKey:@"branchId"];
        self.emailAddress = [decoder decodeObjectForKey:@"emailAddress"];
        self.passcode = [decoder decodeObjectForKey:@"passcode"];
        self.role = [decoder decodeObjectForKey:@"role"];
        self.salt = [decoder decodeObjectForKey:@"salt"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
        self.authToken = [decoder decodeObjectForKey:@"authToken"];
    }
    return self;
}

@end
