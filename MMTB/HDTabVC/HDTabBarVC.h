//
//  HDTabBarVC.h
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDBaseViewModel;
@interface HDTabBarVC : UITabBarController
-(instancetype)initWithViewModel:(HDBaseViewModel *)viewModel;
@end
