//
//  HDTabBarViewModel.m
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDTabBarViewModel.h"
#import "HDHomeViewModel.h"
#import "HDMessageViewModel.h"
#import "HDMineViewModel.h"

@implementation HDTabBarViewModel
/**
 *  GET
 *
 *  @return <#return value description#>
 */
- (HDHomeViewModel *)homeViewModel
{
    if (!_homeViewModel) {
        _homeViewModel = [[HDHomeViewModel alloc] initWithBlock:nil];
    }
    return _homeViewModel;
}
- (HDMessageViewModel *)messageViewModel
{
    if (!_messageViewModel) {
        _messageViewModel = [[HDMessageViewModel alloc] initWithBlock:nil];
    }
    return _messageViewModel;
}
- (HDMineViewModel *)mineViewModel
{
    if (!_mineViewModel) {
        _mineViewModel = [[HDMineViewModel alloc] initWithBlock:nil];
    }
    return _mineViewModel;
}


@end
