//
//  HDNavigationControllerStack.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDNavigationControllerStack.h"
#import "ReactiveCocoa.h"
#import "HDBaseNVC.h"
#import "AppDelegate.h"
#import "HDViewModelServicesProtocol.h"
#import "HDVVMRouter.h"
#import "HDTabBarVC.h"

@interface HDNavigationControllerStack ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id<HDViewModelServicesProtocol> services;
@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation HDNavigationControllerStack
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    HDNavigationControllerStack *navigationControllerStack = [super allocWithZone:zone];
    
    @weakify(navigationControllerStack)
    [[navigationControllerStack
      rac_signalForSelector:@selector(initWithServices:)]
    	subscribeNext:^(id x) {
            @strongify(navigationControllerStack)
            [navigationControllerStack registerNavigationHooks];
        }];
    
    return navigationControllerStack;
}

- (instancetype)initWithServices:(id<HDViewModelServicesProtocol>)services {
    self = [super init];
    if (self) {
        _services = services;
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) return;
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}

- (void)registerNavigationHooks {
    @weakify(self)
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(pushViewModel:animated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         UIViewController *viewController = [[HDVVMRouter sharedHDVVMRouter] hd_VCForVM:tuple.first];
         viewController.hidesBottomBarWhenPushed = YES;
         [self.navigationControllers.lastObject pushViewController:viewController animated:[tuple.second boolValue]];
     }];
    
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(popViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
        	@strongify(self)
         [self.navigationControllers.lastObject popViewControllerAnimated:[tuple.first boolValue]];
     }];
    
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(popToRootViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
     }];
    
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(presentViewModel:animated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
        	@strongify(self)
         UIViewController *viewController = (UIViewController *)[[HDVVMRouter sharedHDVVMRouter] hd_VCForVM:tuple.first];
         
         UINavigationController *presentingViewController = self.navigationControllers.lastObject;
         if (![viewController isKindOfClass:UINavigationController.class]) {
             viewController = [[HDBaseNVC alloc] initWithRootViewController:viewController];
         }
         [self pushNavigationController:(UINavigationController *)viewController];
         
         [presentingViewController presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
     }];
    
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self popNavigationController];
         [self.navigationControllers.lastObject dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
     }];
    
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(resetWindowRootViewModel:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self.navigationControllers removeAllObjects];
         
         UIViewController *viewController = (UIViewController *)[[HDVVMRouter sharedHDVVMRouter] hd_VCForVM:tuple.first];
         
         if (![viewController isKindOfClass:[UINavigationController class]]&& ![viewController isKindOfClass:[HDTabBarVC class]]) {
             viewController = [[HDBaseNVC alloc] initWithRootViewController:viewController];
             ((UINavigationController *)viewController).delegate = self;
             [self pushNavigationController:(UINavigationController *)viewController];
         }
         
         HDSharedAppDelegate.window.rootViewController = viewController;
         
     }];
}

/**
 *  GET&&SETER
 */
-(NSMutableArray *)navigationControllers{
    if (!_navigationControllers) {
        _navigationControllers = [NSMutableArray array];
    }
    return _navigationControllers;
}
@end
