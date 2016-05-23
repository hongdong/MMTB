//
//  AppDelegate.m
//  MMTB
//
//  Created by 洪东 on 16/1/22.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "AppDelegate.h"
#import "HDNavigation.h"
#import "HDLoginManager.h"
#import <iConsole/iConsole.h>
#import "IQKeyboardManager.h"
#import "SVProgressHUD.h"
#import <MMPopupView.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    #ifdef DEBUG
    [iConsole sharedConsole].enabled=YES;
    #else
    [iConsole sharedConsole].enabled=NO;
    #endif
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1];

    [self configAppearanceUI];
    
    [HDNavigation HDResetWindowRootViewModel:[self createInitialViewModel]];
    
    return YES;
    
}

- (HDBaseViewModel *)createInitialViewModel {
    if ([HDLoginManager isLogin]) {
        return nil;
    }else{
        return nil;
    }
}



- (void)configAppearanceUI{
    self.window.backgroundColor=[UIColor whiteColor];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  GET&&SETER
 *
 */

-(UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _window;
}


@end
