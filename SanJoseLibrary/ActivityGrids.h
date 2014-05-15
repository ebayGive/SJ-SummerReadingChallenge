//
//  ActivityGridCollection.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionsProtocol.h"
#import "ActivityGrid.h"

@interface ActivityGrids : NSObject

@property (nonatomic, strong) NSArray *activityGrids;

- (id)activityGridsWithProperties:(NSArray *)properties;

- (ActivityGrid *)activityGridForUserId:(NSString *)userId;

@end
