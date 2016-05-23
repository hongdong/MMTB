//
//  HDTabBarViewModel.m
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDTabBarViewModel.h"

@implementation HDTabBarViewModel
/**
 *  GET
 *
 *  @return <#return value description#>
 */
- (HDBaseViewModel *)homeViewModel
{
    if (!_homeViewModel) {
        _homeViewModel = [[HDBaseViewModel alloc] initWithBlock:nil];
    }
    return _homeViewModel;
}
- (HDBaseViewModel *)messageViewModel
{
    if (!_messageViewModel) {
        _messageViewModel = [[HDBaseViewModel alloc] initWithBlock:nil];
    }
    return _messageViewModel;
}
- (HDBaseViewModel *)mineViewModel
{
    if (!_mineViewModel) {
        _mineViewModel = [[HDBaseViewModel alloc] initWithBlock:nil];
    }
    return _mineViewModel;
}


@end
