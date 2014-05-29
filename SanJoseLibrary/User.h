//
//  User.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Prize;
@protocol Activity;
@class Activity;

@interface User : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *readingLog;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSArray<Prize> *prizes;
@property (nonatomic, strong) NSArray<Activity> *activityGrid;

-(NSString *)fullName;
-(void)incrementReadingLog;
-(void)updateActivity:(Activity *)userActivity atIndex:(NSInteger)cellIndex;
@end
