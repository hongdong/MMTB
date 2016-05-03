//
//  HDBaseNVC.h
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDBaseViewModel;
@interface HDBaseNVC : UINavigationController
-(instancetype)initWithRootViewModel:(__kindof HDBaseViewModel *)viewModel;
@end
