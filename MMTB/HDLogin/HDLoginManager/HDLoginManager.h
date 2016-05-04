//
//  HDLoginManager.h
//  MMTB
//
//  Created by 洪东 on 5/4/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDModelUser;

@interface HDLoginManager : NSObject
+ (BOOL) isLogin;
+ (BOOL) isLoginAndShowLoginView;
+ (void) doLogin:(NSDictionary *)loginData;
+ (void) doLoginModel:(HDModelUser *)user;
+ (void) updateUserInfo:(HDModelUser *)user;
+ (void) doLogout;
+ (HDModelUser *) curLoginUser;
@end
