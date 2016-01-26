//
//  HDTabBarVM.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDTabBarVM.h"
#import "HDHomeVM.h"
#import "HDMineVM.h"

@implementation HDTabBarVM

- (void)initialize {
    [super initialize];
    self.homeVM    = [[HDHomeVM alloc] initWithServices:self.services params:nil];
    self.mineVM   = [[HDMineVM alloc] initWithServices:self.services params:nil];
}
@end
