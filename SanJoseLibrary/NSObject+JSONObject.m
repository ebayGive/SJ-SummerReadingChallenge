//
//  NSObject+JSONObject.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/7/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "NSObject+JSONObject.h"
#import "NSObject+Properties.h"
#import "CollectionsProtocol.h"

@implementation NSObject (JSONObject)

+ (id)JSONObjectWithProperties:(NSDictionary *)properties {
    return [[self alloc] initWithProperties:properties];
}

- (id)initWithJSONProperties:(NSDictionary *)properties
{
    if (self = [self init])
    {
        for (NSString *propertyName in [self propertyNames]) {
            [self populateValue:[properties valueForKey:propertyName] forKey:propertyName];
        }
//        NSDictionary *jsonDict = [properties dictionaryWithValuesForKeys:[self propertyNames]];
//        
//        [self setValuesForKeysWithDictionary:jsonDict];
    }
    return self;
}

- (Class)classForPropertyNamed:(NSString *)propertyName
{
    Class classForKey = nil;
    const char * c = [self typeOfPropertyNamed:propertyName];
    if (c) {
        NSString *classStr = [NSString stringWithUTF8String:c];
        classStr = [[classStr componentsSeparatedByString:@"@"] objectAtIndex:1];
        classStr = [classStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        classForKey = NSClassFromString(classStr);
    }
    return classForKey;
}

-(void)populateValue:(id)value forKey:(NSString *)key
{
    Class classForKey = [self classForPropertyNamed:key];
    
    if ([[value class] isSubclassOfClass:[NSArray class]]) {
        
        NSMutableArray *mutableValue = [NSMutableArray arrayWithCapacity:[value count]];
        
        for (id obj in value) {
            NSString * type = nil;
            if ([classForKey conformsToProtocol:@protocol(CollectionsProtocol)]) {
                type = [classForKey performSelector:@selector(collectionType)];
                id o = [[NSClassFromString(type) alloc] initWithJSONProperties:obj];
                [mutableValue addObject:o];
            }
        }
        [self setValue:[NSArray arrayWithArray:mutableValue] forKey:key];
    }
    else
    {
        [self setValue:value forKey:key];
    }
}


@end
