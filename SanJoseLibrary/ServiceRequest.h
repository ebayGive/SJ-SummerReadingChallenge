//
//  ServiceRequest.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ServiceRequestCompletion)(NSDictionary *json, NSURLResponse *response, NSError *error);

@class Account;
@class User;
@class Activity;

@interface ServiceRequest : NSObject

+(instancetype)sharedRequest;
-(instancetype) initWithSession:(NSURLSession *)session;


- (void)startAddUserTaskWithParameters:(User *)param
                     completionHandler:(ServiceRequestCompletion)handler;
- (void)startRegisterTaskWithParameters:(Account *)param
                      completionHandler:(ServiceRequestCompletion)handler;
- (void)startLoginTaskWithParameters:(Account *)param
                   completionHandler:(ServiceRequestCompletion)handler;
- (void)getUserAccountDetailsWithCompletionHandler:(ServiceRequestCompletion)handler;
- (void)getBranchDetailsWithCompletionHandler:(ServiceRequestCompletion)handler;
- (void)getGridDetailsWithCompletionHandler:(ServiceRequestCompletion)handler;
- (void)getUserTypesWithCompletionHandler:(ServiceRequestCompletion)handler;
- (void)getPrizeAndUserTypesWithCompletionHandler:(ServiceRequestCompletion)handler;
-(void)updateAvtivityForUserID:(NSString *)userId
                  userActivity:(Activity *)userActivity
                     cellIndex:(NSString *)cellIndex
             completionHandler:(ServiceRequestCompletion)handler;
-(void)updateReadingLogForUser:(User *)user
             completionHandler:(ServiceRequestCompletion)handler;
@end
