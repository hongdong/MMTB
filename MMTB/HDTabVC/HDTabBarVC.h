//
//  HDTabBarVC.h
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDTabBarViewModel;
@interface HDTabBarVC : UITabBarController
-(instancetype)initWithViewModel:(HDTabBarViewModel *)viewModel;
@end
