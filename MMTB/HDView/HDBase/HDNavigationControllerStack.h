//
//  HDNavigationControllerStack.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol HDViewModelServicesProtocol;

@interface HDNavigationControllerStack : NSObject

- (instancetype)initWithServices:(id<HDViewModelServicesProtocol>)services;

- (void)pushNavigationController:(UINavigationController *)navigationController;

- (UINavigationController *)popNavigationController;

- (UINavigationController *)topNavigationController;

@end
