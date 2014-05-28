//
//  Account.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JSONObject.h"

@protocol User;

@interface Account : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *passcode;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *salt;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSArray<User> *users;

@property (nonatomic, strong) NSString *authToken;

+ (id)AccountWithProperties:(NSDictionary *)properties;

@end
