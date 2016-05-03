//
//  HDNavigation.m
//  MMTB
//
//  Created by 洪东 on 5/3/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDNavigation.h"
#import "HDBaseViewModel.h"
#import "HDBaseVC.h"
#import "JZNavigationExtension.h"
#import "HDBaseNVC.h"
#import "AppDelegate.h"

@implementation HDNavigation

HDSingletonM(HDNavigation)

- (void)pushViewModel:(__kindof HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(jz_navigation_block_t)completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        __kindof HDBaseVC *vc = [viewModel routerVC];
        if ([[self class] visibleNavigationController].viewControllers.count > 0){
            vc.hidesBottomBarWhenPushed = YES;
        }
        [[[self class] visibleNavigationController] jz_pushViewController:vc animated:animated completion:completion];
    });
    
}

- (void)popViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[self class] visibleNavigationController].viewControllers.count == 2){
            [[self class] visibleNavigationController].tabBarController.tabBar.hidden = NO;
        }
        [[[self class] visibleNavigationController] jz_popViewControllerAnimated:animated completion:completion];
    });
}

- (void)popToRootViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self class] visibleNavigationController].tabBarController.tabBar.hidden = NO;
        [[[self class] visibleNavigationController] jz_popToRootViewControllerAnimated:animated completion:completion];
    });
}


- (void)pushViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated {
    [self pushViewModel:viewModel animated:animated completion:nil];
}

- (void)popViewModelAnimated:(BOOL)animated {
    [self popViewModelAnimated:animated completion:nil];
}

- (void)popToRootViewModelAnimated:(BOOL)animated {
    [self popToRootViewModelAnimated:animated completion:nil];
}

- (void)presentViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[[self class] visibleViewController] presentViewController:[[HDBaseNVC alloc] initWithRootViewModel:viewModel] animated:animated completion:completion];
        
    });
    
}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[self class] visibleViewController] dismissViewControllerAnimated:animated completion:completion];
        
    });
}


- (void)resetWindowRootViewModel:(HDBaseViewModel *)viewModel{
    HDAppDelegate.window.rootViewController = [viewModel routerVC];
    [HDAppDelegate.window makeKeyAndVisible];
}

+ (void)HDTabBarControllerSelectedIndex:(NSInteger) index{
    UIViewController *vc=[[self class] visibleViewController];
    vc.tabBarController.selectedIndex=index;
}

+ (void)HDPushViewModel:(__kindof HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(jz_navigation_block_t)completion{
    if (viewModel) {
        [[[self class] sharedHDNavigation] pushViewModel:viewModel animated:animated completion:(jz_navigation_block_t)completion];
    }
}

+ (void)HDPopViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion{
    [[[self class] sharedHDNavigation] popViewModelAnimated:animated completion:(jz_navigation_block_t)completion];
}

+ (void)HDPopToRootViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion{
    [[[self class] sharedHDNavigation] popToRootViewModelAnimated:animated completion:(jz_navigation_block_t)completion];
}


+ (void)HDPushViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated{
    [[[self class] sharedHDNavigation] pushViewModel:viewModel animated:animated completion:nil];
}

+ (void)HDPopViewModelAnimated:(BOOL)animated{
    [[[self class] sharedHDNavigation] popViewModelAnimated:animated completion:nil];
}

+ (void)HDPopToRootViewModelAnimated:(BOOL)animated{
    [[[self class] sharedHDNavigation] popToRootViewModelAnimated:animated completion:nil];
}

+ (void)HDPresentViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion{
    [[[self class] sharedHDNavigation] presentViewModel:viewModel animated:animated completion:completion];
}

+ (void)HDDismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion{
    [[[self class] sharedHDNavigation] dismissViewModelAnimated:YES completion:completion];
}

+ (void)HDResetWindowRootViewModel:(HDBaseViewModel *)viewModel{
    [[[self class] sharedHDNavigation] resetWindowRootViewModel:viewModel];
}



+ (UINavigationController *)visibleNavigationController
{
    UIViewController *vc = [self visibleViewController];
    UINavigationController *nvc = (UINavigationController *)([vc isKindOfClass:[UINavigationController class]] ? vc : vc.navigationController);
    return nvc;
}

+ (UIViewController *)visibleViewController{
    UIViewController *vc = [self visibleViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    return vc;
}


+ (UIViewController*)visibleViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tbc = (UITabBarController*)rootViewController;
        return [self visibleViewControllerWithRootViewController:tbc.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nvc = (UINavigationController*)rootViewController;
        return [self visibleViewControllerWithRootViewController:nvc.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController *presentedVC = rootViewController.presentedViewController;
        return [self visibleViewControllerWithRootViewController:presentedVC];
    }
    else
    {
        return rootViewController;
    }
}
@end
