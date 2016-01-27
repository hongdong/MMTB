//
//  UIView+HDMVVM.h
//  MMTB
//
//  Created by Abner on 16/1/27.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDViewProtocol.h"
@class HDBaseVM;
NS_ASSUME_NONNULL_BEGIN
@interface UIView (HDMVVM)<HDViewProtocol>
@property (nonatomic,strong) __kindof HDBaseVM *hd_vm;
@end
NS_ASSUME_NONNULL_END