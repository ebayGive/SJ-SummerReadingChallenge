//
//  UserTypes.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTypes : NSObject

@property (nonatomic, strong) NSArray *userTypes;

- (id)userTypesWithProperties:(NSArray *)properties;

- (UIColor *)colorForUserType:(NSString *)userType;
-(NSString *)nameForUserType:(NSString *)userType;

@end
