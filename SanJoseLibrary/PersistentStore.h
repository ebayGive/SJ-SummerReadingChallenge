//
//  PersistentStore.h
//  Countdown
//
//  Created by Himanshu Tantia on 4/8/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginParameters;
@class Account;

@interface PersistentStore : NSObject

+(void)saveAccountDetails:(Account *)account;
+(Account *)accountDetails;
+ (void)deleteAccount;

@end
