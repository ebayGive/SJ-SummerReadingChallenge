//
//  PrizeTypes.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/20/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PrizeType;

@interface PrizeTypes : NSObject

@property (nonatomic, strong) NSArray *prizeTypes;

- (id)prizeTypesWithProperties:(NSArray *)properties;

-(PrizeType *)prizesForUserType:(NSString *)userType;

@end
