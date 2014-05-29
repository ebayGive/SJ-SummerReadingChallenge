//
//  Prize.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prize : NSObject

@property (nonatomic) int state;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *updatedAt;

@end
