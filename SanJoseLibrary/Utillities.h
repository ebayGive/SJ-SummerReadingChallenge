//
//  Utillities.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/8/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Utillities : NSObject

+(UIAlertView *)alertViewWithTitle:(NSString *)title
                           message:(NSString *)msg
                          delegate:(id)delegate
                 cancelButtonTitle:(NSString *)cancelTitle
                 otherButtonTitles:(NSString *)otherTitles, ...;

@end
