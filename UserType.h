//
//  UserTypes.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserType : NSObject

@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *minAge;
@property (nonatomic, strong) NSString *maxAge;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UIColor *color;

@end
