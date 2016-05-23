//
//  GVUserDefaults+Properties.m
//  GVUserDefaults
//
//  Created by Kevin Renskers on 18-12-12.
//  Copyright (c) 2012 Gangverk. All rights reserved.
//

#import "GVUserDefaults+Properties.h"

@implementation GVUserDefaults (Properties)

@dynamic registrationID;
@dynamic loginUserDict;
@dynamic loginStatus;
@dynamic badge;
@dynamic unreadNum;

- (NSDictionary *)setupDefaults {
    return @{
        @"unreadNum":@0,
        @"badge":@0
    };
}
//
//- (NSString *)transformKey:(NSString *)key {
//    key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] uppercaseString]];
//    return [NSString stringWithFormat:@"NSUserDefault%@", key];
//}

@end
