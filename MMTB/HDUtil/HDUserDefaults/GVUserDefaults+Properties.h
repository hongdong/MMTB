//
//  GVUserDefaults+Properties.h
//  GVUserDefaults
//
//  Created by Kevin Renskers on 18-12-12.
//  Copyright (c) 2012 Gangverk. All rights reserved.
//

#import "GVUserDefaults.h"

@interface GVUserDefaults (Properties)

@property (nonatomic, strong) NSNumber *loginStatus;

@property (nonatomic, strong) NSDictionary *loginUserDict;

@property (nonatomic,strong) NSString *registrationID;//推送使用的设备ID

@property (strong,nonatomic) NSNumber *badge;

@property (strong,nonatomic) NSNumber *unreadNum;//消息未读

@end
