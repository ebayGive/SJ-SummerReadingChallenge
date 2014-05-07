//
//  ServiceRequest.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ServiceRequestCompletion)(NSDictionary *json, NSURLResponse *response, NSError *error);

@class LoginParameters;

@interface ServiceRequest : NSObject

-(instancetype) initWithSession:(NSURLSession *)session;
- (void)startLoginTaskWithParameters:(LoginParameters *)param
                   completionHandler:(ServiceRequestCompletion)handler;

@end
