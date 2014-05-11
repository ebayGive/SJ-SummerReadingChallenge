//
//  UserArray.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionsProtocol.h"
#import "User.h"

@interface UserCollection : NSObject <CollectionsProtocol>

@property (nonatomic, strong) NSArray *container;

@end
