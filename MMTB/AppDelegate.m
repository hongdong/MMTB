//
//  AppDelegate.m
//  MMTB
//
//  Created by 洪东 on 16/1/22.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "AppDelegate.h"
#import "HDTabBarVC.h"
#import "HDVMServices.h"
#import "HDNavigationControllerStack.h"
#import "HDTabBarVM.h"

@interface AppDelegate ()

@property (nonatomic, strong)  HDVMServices *services;

@property (nonatomic, strong, readwrite) HDNavigationControllerStack *navigationControllerStack;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //懒初始化HDNavigationControllerStack
    [self navigationControllerStack];
    [self.services resetWindowRootViewModel:[self createInitialViewModel]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (HDBaseVM *)createInitialViewModel {
        return [[HDTabBarVM alloc] initWithServices:self.services params:nil];
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

-(HDTabBarVC *)tabBarController{
    if (!_tabBarController) {
        _tabBarController = [[HDTabBarVC alloc] init];
    }
    return _tabBarController;
}

-(HDVMServices *)services{
    if (!_services) {
        _services = [[HDVMServices alloc] init];
    }
    return _services;
}

-(HDNavigationControllerStack *)navigationControllerStack{
    if (!_navigationControllerStack) {
        _navigationControllerStack = [[HDNavigationControllerStack alloc] initWithServices:self.services];
    }
    return _navigationControllerStack;
}


@end
