//
//  CollectionsProtocol.h
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CollectionsProtocol <NSObject>

@required
+(Class)collectionType;
-(id)collectionContainer;
-(void)setCollectionContainer:(id)val;
@end
