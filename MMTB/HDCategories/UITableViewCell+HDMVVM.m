//
//  UITableViewCell+HDMVVM.m
//  MMTB
//
//  Created by Abner on 16/1/27.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "UITableViewCell+HDMVVM.h"
#import <objc/runtime.h>
#import "HDBaseVM.h"
@implementation UITableViewCell (HDMVVM)
- (HDBaseVM *)hd_vm
{
    HDBaseVM *curVM = objc_getAssociatedObject(self,@selector(hd_vm));
    return curVM;
}

- (void)setHd_vm:(HDBaseVM *)hd_vm
{
    objc_setAssociatedObject(self, @selector(hd_vm), hd_vm, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self respondsToSelector:@selector(hd_bindViewModel)]) {
        [self performSelectorOnMainThread:@selector(hd_bindViewModel) withObject:nil waitUntilDone:NO];
    }
}
@end
