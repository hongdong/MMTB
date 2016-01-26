//
//  HDBaseVC.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDBaseVM;
@interface HDBaseVC : UIViewController

- (instancetype)initWithViewModel:(HDBaseVM *)viewModel;

@end
