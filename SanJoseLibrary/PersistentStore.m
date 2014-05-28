//
//  PersistentStore.m
//  Countdown
//
//  Created by Himanshu Tantia on 4/8/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "PersistentStore.h"
#import "Account.h"
#import "KeychainItemWrapper.h"

static NSUserDefaults *standardPersistentStore;
static KeychainItemWrapper *standardKeychainItemWrapper;
@interface PersistentStore ()

@end

@implementation PersistentStore

+ (NSUserDefaults *)standardPersistentStore
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        standardPersistentStore = [NSUserDefaults standardUserDefaults];
    });
    return standardPersistentStore;
}

+ (KeychainItemWrapper *)keychainWrapper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        standardKeychainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"sjslib"
                                                                          accessGroup:nil];
    });
    return standardKeychainItemWrapper;
}

+(void)saveAccountDetails:(Account *)account
{
    if (account) {
        [self saveObject:account withKey:@"Account"];
    }
}

+(Account *)accountDetails
{
    Account *account = [self objectWithKey:@"Account"];;
    return account;
}

+ (void)deleteAccount
{
    [[self standardPersistentStore] removeObjectForKey:@"Account"];
}

+(BOOL)saveObject:(id)obj withKey:(NSString *)key
{
    if (obj) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [[self standardPersistentStore] setObject:data forKey:key];
        return [[self standardPersistentStore] synchronize];
    }
    return NO;
}

+(id)objectWithKey:(NSString *)key
{
    id obj = nil;
    NSData *data = [[self standardPersistentStore] objectForKey:key];
    if ([data length]) {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return obj;
}

@end
