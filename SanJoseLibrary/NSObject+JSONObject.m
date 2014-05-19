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
    }
    return self;
}

- (NSDictionary *)classForPropertyNamed:(NSString *)propertyName
{
    NSString *classForKey = @"";
    NSString *protocolForKey = @"";
    const char * c = [self typeOfPropertyNamed:propertyName];
    if (c)
    {
        NSString *classStr = [NSString stringWithUTF8String:c];
        NSArray *temp = [classStr componentsSeparatedByString:@"@"];
        if ([temp count]>=2) {
            classStr = [temp objectAtIndex:1];
        }
        classStr = [classStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
        NSRange startRange = [classStr rangeOfString:@"<"];
        NSRange endRange = [classStr rangeOfString:@">"];
        if (startRange.location != NSNotFound)
        {
            classForKey = [classStr substringToIndex:startRange.location];
            protocolForKey = [classStr substringWithRange:
                        NSMakeRange(startRange.location+1, (endRange.location-startRange.location)-1)];
        }
        else
        {
            classForKey = classStr;
        }
    }
    return @{@"c": classForKey, @"p":protocolForKey};
}

-(void)populateValue:(id)value forKey:(NSString *)key
{
    NSDictionary *class_protocol = [self classForPropertyNamed:key];
    Class classForKey = NSClassFromString([class_protocol valueForKey:@"c"]);
    Class protocolClass = NSClassFromString([class_protocol valueForKey:@"p"]);
    
    if ([[value class] isSubclassOfClass:[NSArray class]] &&
        protocolClass)
    {
        Class classOfObj = protocolClass;
        NSMutableArray *mutableValue = [NSMutableArray arrayWithCapacity:[value count]];
        
        for (id obj in value) {
            id o = [[classOfObj alloc] initWithJSONProperties:obj];
            [mutableValue addObject:o];
        }
        [self setValue:[mutableValue copy] forKeyPath:key];
    }
    else if ([[value class] isSubclassOfClass:[NSDictionary class]] &&
             classForKey)
    {
        Class classOfObj = classForKey;
        id o = [[classOfObj alloc] initWithJSONProperties:value];
        [self setValue:o forKey:key];
    }
    else
    {
        [self setValue:value forKey:key];
    }
}


@end
