//
//  Utillities.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/8/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "Utillities.h"

@implementation Utillities

+(UIAlertView *)alertViewWithTitle:(NSString *)title
                              message:(NSString *)msg
                             delegate:(id)delegate
                    cancelButtonTitle:(NSString *)cancelTitle
                    otherButtonTitles:(NSString *)otherTitles, ...
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles, nil];
    return alert;
}

+(void)showBasicNetworkError
{
    [[self alertViewWithTitle:@"Request Error" message:@"Please check your network connection or try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

+(void)showBasicInputError
{
    [[self alertViewWithTitle:@"Data Error" message:@"Please check the entered values" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
