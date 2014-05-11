//
//  PrizesCollection.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionsProtocol.h"
#import "Prize.h"

@interface PrizesCollection : NSObject <CollectionsProtocol>

@property (nonatomic, strong) NSArray *container;

@end
