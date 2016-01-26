//
//  HDNavigationProtocol.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDBaseVM.h"

@protocol HDNavigationProtocol <NSObject>

- (void)pushViewModel:(HDBaseVM * _Nonnull )viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(HDBaseVM * _Nonnull)viewModel animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

- (void)resetWindowRootViewModel:(HDBaseVM * _Nonnull)viewModel;


@end
