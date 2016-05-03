//
//  HDNavigation.h
//  MMTB
//
//  Created by 洪东 on 5/3/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HDCommonHeader.h"

typedef void(^jz_navigation_block_t)(UINavigationController *navigationController, BOOL finished);

@class HDBaseViewModel;

@interface HDNavigation : NSObject

HDSingletonH(HDNavigation)

- (void)pushViewModel:(__kindof HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(jz_navigation_block_t)completion;

- (void)popViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion;

- (void)popToRootViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion;


- (void)pushViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;



- (void)presentViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

- (void)resetWindowRootViewModel:(HDBaseViewModel *)viewModel;



+ (void)HDTabBarControllerSelectedIndex:(NSInteger) index;

+ (void)HDPushViewModel:(__kindof HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(jz_navigation_block_t)completion;

+ (void)HDPopViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion;

+ (void)HDPopToRootViewModelAnimated:(BOOL)animated completion:(jz_navigation_block_t)completion;

+ (void)HDPushViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated;

+ (void)HDPopViewModelAnimated:(BOOL)animated;

+ (void)HDPopToRootViewModelAnimated:(BOOL)animated;

+ (void)HDPresentViewModel:(HDBaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

+ (void)HDDismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

+ (void)HDResetWindowRootViewModel:(HDBaseViewModel *)viewModel;



+ (UIViewController *)visibleViewController;

+ (UINavigationController *)visibleNavigationController;

+ (UIViewController*)visibleViewControllerWithRootViewController:(UIViewController*)rootViewController;

@end
