//
//  User.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "User.h"

@implementation User

-(NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.id
                   forKey:@"id"];
    [encoder encodeObject:self.firstName
                   forKey:@"firstName"];
    [encoder encodeObject:self.lastName
                   forKey:@"lastName"];
    [encoder encodeObject:self.userType
                   forKey:@"userType"];
    [encoder encodeObject:self.readingLog
                   forKey:@"readingLog"];
    [encoder encodeObject:self.prizes
                   forKey:@"prizes"];
    [encoder encodeObject:self.activityGrid
                   forKey:@"activityGrid"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        self.id = [decoder decodeObjectForKey:@"id"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.readingLog = [decoder decodeObjectForKey:@"readingLog"];
        self.userType = [decoder decodeObjectForKey:@"userType"];
        self.prizes = [decoder decodeObjectForKey:@"prizes"];
        self.activityGrid = [decoder decodeObjectForKey:@"activityGrid"];
    }
    return self;
}

-(NSNumber *)readingLog
{
    if ([_readingLog integerValue]>900)
        _readingLog = [NSNumber numberWithInteger:900];
    else if ([_readingLog integerValue]<0)
        _readingLog = [NSNumber numberWithInteger:0];
    
    return _readingLog;
}

-(void)incrementReadingLog
{
    NSInteger current = [self.readingLog integerValue];
    current = current+20;
    self.readingLog = [NSNumber numberWithInteger:current];
}

@end
