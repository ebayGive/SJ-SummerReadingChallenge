//
//  ActivityGridCellData.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/13/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityGridCellContents.h"

@implementation ActivityGridCellContents

-(NSURL *)url
{
    if (_url) {
        return _url;
    }
    NSDataDetector *links = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                            error:nil];
    NSArray *linkArray = [links matchesInString:self.description
                                        options:0
                                          range:NSMakeRange(0, self.description.length)];
    
    _url = [[linkArray firstObject] URL];
    return _url;
}

@end
