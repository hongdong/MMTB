//
//  HDTabBarViewModel.h
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDBaseViewModel.h"
#import "HDHomeViewModel.h"
#import "HDMessageViewModel.h"
#import "HDMineViewModel.h"

@interface HDTabBarViewModel : HDBaseViewModel

@property (nonatomic, strong) HDHomeViewModel *homeViewModel;
@property (nonatomic, strong) HDMessageViewModel *messageViewModel;
@property (nonatomic, strong) HDMineViewModel *mineViewModel;

@property (nonatomic, strong) NSNumber *selectIndex;

@end
