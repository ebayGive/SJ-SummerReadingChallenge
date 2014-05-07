//
//  User.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActivityGridCollection;
@class PrizesCollection;

@interface User : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *readingLog;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) PrizesCollection *prizes;
@property (nonatomic, strong) ActivityGridCollection *activityGrid;

@end
