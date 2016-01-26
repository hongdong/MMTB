//
//  HDVVMRouter.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDVVMRouter.h"
#import "HDBaseVM.h"
#import "HDBaseVC.h"

@interface HDVVMRouter ()

@property (nonatomic, copy) NSDictionary<NSString *,NSString *> *vmvcMapDic;

@end

@implementation HDVVMRouter
HDSingletonM(HDVVMRouter)

- (UIViewController *)hd_VCForVM:(HDBaseVM *)vm{
    NSString *viewController = self.vmvcMapDic[NSStringFromClass(vm.class)];
    return [[NSClassFromString(viewController) alloc] initWithViewModel:vm];
}

- (HDBaseVM *)hd_VMForVC:(UIViewController *)vc{
    NSArray *keysArr = [self.vmvcMapDic allKeysForObject:NSStringFromClass(vc.class)];
    NSString *vmClassName = [keysArr firstObject];
    return [[NSClassFromString(vmClassName) alloc] init];
}

/**
 *  GET
 */
-(NSDictionary *)vmvcMapDic{
    if (!_vmvcMapDic) {
        _vmvcMapDic = @{@"HDTabBarVM":@"HDTabBarVC",
                                    @"HDHomeVM":@"HDHomeVC",
                                    @"HDMineVM":@"HDMineVC"};
    }
    return _vmvcMapDic;
}

@end
