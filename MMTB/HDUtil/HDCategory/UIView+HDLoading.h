//
//  UIView+HDLoading.h
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HDLoading)

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

- (void)HDBeginLoading;
- (void)HDEndLoading;


@end
