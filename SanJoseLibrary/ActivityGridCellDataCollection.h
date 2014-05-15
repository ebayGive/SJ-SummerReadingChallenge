//
//  ActivityGridCellDataCollection.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionsProtocol.h"
#import "ActivityGridCellContents.h"

@interface ActivityGridCellDataCollection : NSObject <CollectionsProtocol>

@property (nonatomic, strong) NSArray *container;

@end
