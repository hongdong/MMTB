//
//  HDTabBarViewModel.h
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDBaseViewModel.h"
@class HDBaseViewModel;
@interface HDTabBarViewModel : HDBaseViewModel

@property (nonatomic, strong) HDBaseViewModel *homeViewModel;
@property (nonatomic, strong) HDBaseViewModel *messageViewModel;
@property (nonatomic, strong) HDBaseViewModel *mineViewModel;

@property (nonatomic, strong) NSNumber *selectIndex;

@end
