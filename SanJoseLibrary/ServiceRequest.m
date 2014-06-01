//
//  ServiceRequest.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "PersistentStore.h"
#import "ServiceRequest.h"
#import "Account.h"
#import "User.h"
#import "Activity.h"
#import "Utillities.h"

static ServiceRequest *sharedInstance;

@interface ServiceRequest ()

@property (nonatomic, strong) Account *account;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ServiceRequest

-(void)dealloc
{
    [self.session invalidateAndCancel];
}

+(instancetype)sharedRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ServiceRequest alloc] initWithSession:[NSURLSession sharedSession]];
    });
    return sharedInstance;
}

-(instancetype)initWithSession:(NSURLSession *)session {
    
    if(self = [self init]) {
        self.session = session;
    }
    return self;
}

-(void)getPrizeAndUserTypesWithCompletionHandler:(ServiceRequestCompletion)handler
{
    NSString *urlStr = @"http://www.sjplsummer.org/prizes.json";
    
//    id data = [PersistentStore objectWithKey:urlStr];
//    
//    if (data != nil) {
//        NSError *error = nil;
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        handler(json,nil,error);
//        return;
//    }
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createGetRequestForURLPath:urlStr]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
//                                              if (data && [data length]) {
//                                                  [PersistentStore saveObject:data withKey:urlStr];
//                                              }
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              
                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];
}

- (void)getUserTypesWithCompletionHandler:(ServiceRequestCompletion)handler
{
    NSString *urlStr = @"http://www.sjplsummer.org/user_types.json";
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createGetRequestForURLPath:urlStr]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];
}

- (void)getGridDetailsWithCompletionHandler:(ServiceRequestCompletion)handler
{
    NSString *urlStr = @"http://www.sjplsummer.org/grids.json";
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createGetRequestForURLPath:urlStr]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              
                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];
}

- (void)getBranchDetailsWithCompletionHandler:(ServiceRequestCompletion)handler
{
    NSString *urlStr = @"http://www.sjplsummer.org/branches.json";
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createGetRequestForURLPath:urlStr]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              
                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];
}

- (void)getUserAccountDetailsWithCompletionHandler:(ServiceRequestCompletion)handler
{
    Account *acc = [PersistentStore accountDetails];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.sjplsummer.org/accounts/%@.json",acc.id];
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createGetRequestForURLPath:urlStr]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              
                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];

}


-(NSMutableURLRequest *)createGetRequestForURLPath:(NSString *)endpoint
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endpoint]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    return request;
}

-(void)updateAvtivityForUserID:(NSString *)userId
                  userActivity:(Activity *)userActivity
                     cellIndex:(NSString *)cellIndex
             completionHandler:(ServiceRequestCompletion)handler
{
    NSMutableString *userActivityUrl = [NSMutableString stringWithFormat:@"http://www.sjplsummer.org/accounts/%@/users/%@/activity_grid/%@.json?",self.account.id,userId,cellIndex];
    [userActivityUrl appendFormat:@"activity=%d&notes=%@&updatedAt=%@",userActivity.activity,userActivity.notes,userActivity.updatedAt];
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createPutRequestForURLPath:userActivityUrl]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              
                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];

}

-(void)updateReadingLogForUser:(User *)user
             completionHandler:(ServiceRequestCompletion)handler
{
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createRequestWithUser:user]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              
                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];
}

-(NSMutableURLRequest *)createRequestWithUser:(User *)user
{
    NSMutableString *loginURL = [NSMutableString stringWithFormat:@"http://www.sjplsummer.org/accounts/%@/users/%@/reading_log.json?",self.account.id,user.id];
    [loginURL appendFormat:@"readingLog=%@",user.readingLog];
    
    NSMutableURLRequest *req = [self createPutRequestForURLPath:loginURL];
    return req;
}


-(NSMutableURLRequest *)createPutRequestForURLPath:(NSString *)endpoint
{
    endpoint = [endpoint stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endpoint]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"PUT"];
    return request;
}

-(Account *)account
{
    if (_account || [_account.id length]) {
        return _account;
    }
    if ((_account = [PersistentStore accountDetails])) {
        return _account;
    }
    return _account = [Account new];
}

- (void)startAddUserTaskWithParameters:(User *)param
                     completionHandler:(ServiceRequestCompletion)handler
{
    NSDictionary *newUser = @{@"user": @{@"firstName": param.firstName,
                                         @"lastName": param.lastName,
                                         @"userType": param.userType,
                                         @"age":@(param.age)}};
    NSMutableString *urlPath = [NSMutableString stringWithFormat:@"http://www.sjplsummer.org/accounts/%@/users.json?",self.account.id];
    
    [urlPath appendFormat:@"firstName=%@",param.firstName];
    [urlPath appendFormat:@"&lastName=%@",param.lastName];
    [urlPath appendFormat:@"&userType=%@",param.userType];
    [urlPath appendFormat:@"&age=%ld",(long)param.age];
    
    NSMutableURLRequest *req = [self createPostRequestForURLPath:urlPath];
    if ([NSJSONSerialization isValidJSONObject:newUser]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:newUser
                                               options:kNilOptions
                                                 error:nil];
        [req setHTTPBody:data];
    }
    
    NSLog(@"request Data %@",[NSString stringWithUTF8String:[[req HTTPBody] bytes]]);
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:req
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions error:&error];
                                              NSString *errorMessage = json[@"message"];
                                              if (errorMessage && [errorMessage length]) {
                                                  if (error == nil) {
                                                      error = [[NSError alloc] initWithDomain:@"Error Adding User"
                                                                                         code:-1
                                                                                     userInfo:json];
                                                  }
                                                  else
                                                  {
                                                      NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                                                      [userInfo addEntriesFromDictionary:json];
                                                      NSError *err = [[NSError alloc] initWithDomain:error.domain
                                                                                                code:error.code
                                                                                            userInfo:userInfo];
                                                      error = err;
                                                  }
                                              }
                                              
                                              if (json && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json,response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];

}

- (void)startRegisterTaskWithParameters:(Account *)param
                      completionHandler:(ServiceRequestCompletion)handler
{
    self.account = param;
    self.account.accountName = param.accountName;
    self.account.passcode = param.passcode;
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createRequestWithAccountParameters:param]
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              
                                              NSString *errorMessage = json[@"message"];
                                              NSString *errorMsg = json[@"errors"];
                                              if (errorMessage || errorMsg ) {
                                                  if (error == nil) {
                                                      error = [[NSError alloc] initWithDomain:@"Registration Error"
                                                                                         code:-1
                                                                                     userInfo:json];
                                                  }
                                                  else
                                                  {
                                                      NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                                                      [userInfo addEntriesFromDictionary:json[@"message"]];
                                                      [userInfo addEntriesFromDictionary:json[@"errors"]];
                                                      NSError *err = [[NSError alloc] initWithDomain:error.domain
                                                                                                code:error.code
                                                                                            userInfo:userInfo];
                                                      error = err;
                                                  }
                                              }
                                              else
                                              {
                                                  self.account.authToken = json[@"authToken"];
                                                  if (self.account.authToken && [self.account.authToken length]) {
                                                      self.account = [[Account alloc] initWithJSONProperties:json[@"account"]];
                                                      self.account.authToken = json[@"authToken"];
                                                      self.account.passcode = param.passcode;
                                                      [PersistentStore saveAccountDetails:self.account];
                                                  }
                                              }
                                              if (json[@"account"] && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json[@"account"],response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];
}

-(NSMutableURLRequest *)createRequestWithAccountParameters:(Account *)param
{
    NSMutableString *loginURL = [NSMutableString stringWithString:@"http://www.sjplsummer.org/accounts.json?"];
    [loginURL appendFormat:@"accountName=%@&emailAddress=%@&branchId=%@&passcode=%@&role=READER",
     param.accountName,param.emailAddress,param.branchId,param.passcode];
    
    NSDictionary *newAcc = @{@"accountName": param.accountName,
                                         @"emailAddress": param.emailAddress,
                                         @"branchId": param.branchId,
                                         @"passcode": param.passcode,
                                         @"role":@"READER"};
    
    NSMutableURLRequest *req = [self createPostRequestForURLPath:loginURL];
    [req setHTTPBody:[NSJSONSerialization dataWithJSONObject:newAcc
                                                     options:kNilOptions
                                                       error:nil]];
    return req;
}

- (void)startLoginTaskWithParameters:(Account *)param
                   completionHandler:(ServiceRequestCompletion)handler
{
    self.account = param;
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createRequestWithLoginParameters:param]
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              self.account.authToken = json[@"authToken"];
                                              if (self.account.authToken && [self.account.authToken length]) {
                                                  self.account = [[Account alloc] initWithJSONProperties:json[@"account"]];
                                                  self.account.authToken = json[@"authToken"];
                                                  self.account.passcode = param.passcode;
                                                  [PersistentStore saveAccountDetails:self.account];
                                              }

                                              if (json[@"account"] && [(NSHTTPURLResponse*)response statusCode] == 200) {
                                                  handler(json[@"account"],response,error);
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [Utillities showBasicNetworkError];
                                                  });
                                              }
                                          }];
    [postDataTask resume];
}

-(NSMutableURLRequest *)createRequestWithLoginParameters:(Account *)param
{
    NSMutableString *loginURL = [NSMutableString stringWithString:@"http://www.sjplsummer.org/accounts/signin.json?"];
    [loginURL appendFormat:@"accountName=%@&passcode=%@",param.accountName,param.passcode];
    
    return [self createPostRequestForURLPath:loginURL];
}

-(NSMutableURLRequest *)createPostRequestForURLPath:(NSString *)endpoint
{
    endpoint = [endpoint stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endpoint]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    return request;
}

@end
