//
//  HDTabBarVM.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDBaseVM.h"
@class HDHomeVM,HDMineVM;
@interface HDTabBarVM : HDBaseVM

@property (nonatomic, strong) HDHomeVM *homeVM;
@property (nonatomic, strong) HDMineVM *mineVM;

@end
