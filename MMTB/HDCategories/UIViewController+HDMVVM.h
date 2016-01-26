//
//  UIViewController+HDMVVM.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDBaseVM;
NS_ASSUME_NONNULL_BEGIN

@protocol HDVCProtocol <NSObject>
@optional

- (void)hd_bindWithViewModel;

@end

@interface UIViewController (HDMVVM)<HDVCProtocol>

@property (nonatomic,strong) __kindof HDBaseVM *hd_vm;

@end
NS_ASSUME_NONNULL_END
