//
//  HDLoginManager.m
//  MMTB
//
//  Created by 洪东 on 5/4/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDLoginManager.h"
#import "GVUserDefaults+Properties.h"
#import "MJExtension.h"
#import "HDModelUser.h"

static HDModelUser *curLoginUser;


@implementation HDLoginManager

+ (void)doLogin:(NSDictionary *)loginData{
    if (loginData) {
        [GVUserDefaults standardUserDefaults].loginStatus = @YES;
        [GVUserDefaults standardUserDefaults].loginUserDict = loginData;
        curLoginUser = [HDModelUser mj_objectWithKeyValues:loginData];
    }else{
        [HDLoginManager doLogout];
    }
}

+(void)doLoginModel:(HDModelUser *)user{
    if (user) {
        [HDLoginManager doLogin:[user mj_keyValues]];
    }else{
        [HDLoginManager doLogout];
    }
}

+ (void) updateUserInfo:(HDModelUser *)user{
    HDModelUser *cUser = [HDLoginManager curLoginUser];
#warning 转移一些信息
    [HDLoginManager doLoginModel:user];
}

+ (void)doLogout{
    curLoginUser = nil;
    [GVUserDefaults standardUserDefaults].loginStatus = @NO;
    [GVUserDefaults standardUserDefaults].loginUserDict = nil;
#warning 做一些clean操作
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HDNotiHasLogout" object:nil];
}

+ (BOOL)isLogin{
    NSNumber *loginStatus = [GVUserDefaults standardUserDefaults].loginStatus;
    if (loginStatus.boolValue && [HDLoginManager curLoginUser]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isLoginAndShowLoginView{
    if ([HDLoginManager isLogin]) {
        return YES;
    }else{
#warning 发送登入界面转场通知
        return NO;
    }
}


+ (HDModelUser *)curLoginUser{
    if (!curLoginUser) {
        NSDictionary *loginData = [GVUserDefaults standardUserDefaults].loginUserDict;
        curLoginUser = loginData? [HDModelUser mj_objectWithKeyValues:loginData]: nil;
    }
    return curLoginUser;
}


@end
