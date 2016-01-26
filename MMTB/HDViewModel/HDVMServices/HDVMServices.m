//
//  HDVMServices.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDVMServices.h"

@implementation HDVMServices

- (void)pushViewModel:(HDBaseVM *)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(HDBaseVM *)viewModel animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion {}

- (void)resetWindowRootViewModel:(HDBaseVM *)viewModel {}

@end
