//
//  UIViewController+HDMVVM.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "UIViewController+HDMVVM.h"
#import <objc/runtime.h>
#import "HDBaseVM.h"
#import "HDMacrosHeader.h"
#import "HDVVMRouter.h"

@implementation UIViewController (HDMVVM)
- (HDBaseVM *)hd_vm
{
    HDBaseVM *curVM = objc_getAssociatedObject(self,@selector(hd_vm));
    if (curVM) return curVM;
    curVM = [[HDVVMRouter sharedHDVVMRouter] hd_VMForVC:self];
    self.hd_vm = curVM;
    return curVM;
}

- (void)setHd_vm:(HDBaseVM *)hd_vm
{
    objc_setAssociatedObject(self, @selector(hd_vm), hd_vm, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self respondsToSelector:@selector(hd_bindWithViewModel)]) {
        [self performSelectorOnMainThread:@selector(hd_bindWithViewModel) withObject:nil waitUntilDone:NO];
    }
}

@end
