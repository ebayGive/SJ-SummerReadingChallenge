//
//  ActivityGridCellData.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityGridCellContents : NSObject

@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *imgSrc;
@property (nonatomic, strong) NSString *gridIcon;
@property (nonatomic, strong) NSURL *url;

@end
