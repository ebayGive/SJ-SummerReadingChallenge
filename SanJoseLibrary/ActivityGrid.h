//
//  ActivityGrid.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActivityGridCellContents;

@interface ActivityGrid : NSObject

@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSArray<ActivityGridCellContents> *cells;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *type;

@end
