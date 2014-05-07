//
//  Account.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/6/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "Account.h"
#import <objc/runtime.h>
#import "NSObject+Properties.h"
#import "NSString+PropertyKVC.h"
#import "CollectionsProtocol.h"

@implementation Account

+ (id)AccountWithProperties:(NSDictionary *)properties {
    return [[self alloc] initWithJSONProperties:properties];
}

//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    Class classForKey = nil;
//    const char * c = [self typeOfPropertyNamed:key];
//    if (c) {
//        NSString *classStr = [NSString stringWithUTF8String:c];
//        classStr = [[classStr componentsSeparatedByString:@"@"] objectAtIndex:1];
//        classStr = [classStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//        classForKey = NSClassFromString(classStr);
//    }
//    
//    if ([[value class] isSubclassOfClass:[NSArray class]]) {
//        
//        NSMutableArray *mutableValue = [NSMutableArray arrayWithCapacity:[value count]];
//        
//        for (id obj in value) {
//            NSString * type = nil;
//            if ([classForKey conformsToProtocol:@protocol(CollectionsProtocol)]) {
//                type = [classForKey performSelector:@selector(collectionType)];
//                id o = [[NSClassFromString(type) alloc] initWithJSONProperties:obj];
////                NSDictionary *oDict = [obj dictionaryWithValuesForKeys:[o propertyNames]];
////                [o setValuesForKeysWithDictionary:oDict];
//                [mutableValue addObject:o];
//            }
//        }
//        [super setValue:[NSArray arrayWithArray:mutableValue] forKey:key];
//    }
//    else
//    {
//        [super setValue:value forKey:key];
//    }
//}
@end
