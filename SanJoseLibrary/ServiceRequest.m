//
//  ServiceRequest.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ServiceRequest.h"
#import "LoginParameters.h"

@interface ServiceRequest ()

@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ServiceRequest

-(void)dealloc
{
    [self.session invalidateAndCancel];
}

-(instancetype) initWithSession:(NSURLSession *)session {
    
    if(self = [self init]) {
        self.session = session;
    }
    return self;
}

- (void)startLoginTaskWithParameters:(LoginParameters *)param
                   completionHandler:(ServiceRequestCompletion)handler
{
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:[self createLoginRequestWithParameters:param]
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              self.authToken = json[@"authToken"];
                                              handler(json,response,error);
                                          }];
    [postDataTask resume];
}

-(NSMutableURLRequest *)createLoginRequestWithParameters:(LoginParameters *)param
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self loginURLWithParameters:param]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    return request;
}

- (NSURL *)loginURLWithParameters:(LoginParameters *)param
{
    NSMutableString *loginURL = [NSMutableString stringWithString:@"http://hackathon.ebaystratus.com/accounts/signin.json?"];
    [loginURL appendFormat:@"accountName=%@&passcode=%@",param.accountName,param.passcode];
    return [NSURL URLWithString:[loginURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
}

@end
