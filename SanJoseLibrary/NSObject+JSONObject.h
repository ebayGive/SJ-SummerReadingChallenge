//
//  NSObject+JSONObject.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONObject)

+ (id)JSONObjectWithProperties:(NSDictionary *)properties;
- (id)initWithJSONProperties:(NSDictionary *)properties;

@end
