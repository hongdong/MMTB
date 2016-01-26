//
//  UIViewController+HDMVVM.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HDMVVM.h"
#import "HDViewProtocol.h"
@class HDBaseVM;
NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (HDMVVM)<HDViewProtocol>

@property (nonatomic,strong) __kindof HDBaseVM *hd_vm;

@end
NS_ASSUME_NONNULL_END
