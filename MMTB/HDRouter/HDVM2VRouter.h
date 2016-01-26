//
//  HDVM2VRouter.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDMacrosHeader.h"
#import "HDBaseVC.h"
#import "HDBaseVM.h"

@interface HDVM2VRouter : NSObject
HDSingletonH(HDVM2VRouter)

- (HDBaseVC *)viewControllerForViewModel:(HDBaseVM *)viewModel;

@end
