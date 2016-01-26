//
//  HDVVMRouter.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDMacrosHeader.h"
#import <UIKit/UIKit.h>
@class HDBaseVC,HDBaseVM;

@interface HDVVMRouter : NSObject
HDSingletonH(HDVVMRouter)

- (UIViewController *)hd_VCForVM:(HDBaseVM *)vm;
- (HDBaseVM *)hd_VMForVC:(UIViewController *)vc;

@end
