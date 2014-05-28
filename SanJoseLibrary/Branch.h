//
//  Branch.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/8/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Branch : NSObject

@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *hoursOfOperation;
@property (nonatomic, strong, getter = identifier) NSString *id;
@property (nonatomic, strong) NSString *type;

@end
