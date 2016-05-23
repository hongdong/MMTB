//
//  HDTabBarVC.m
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDTabBarVC.h"
#import "HDTabBarViewModel.h"
#import "HDBaseNVC.h"

@interface HDTabBarVC ()

@property (nonatomic, strong) HDTabBarViewModel *viewModel;

@property (nonatomic, strong) HDBaseNVC  *homeNav;
@property (nonatomic, strong) HDBaseNVC  *messageNav;
@property (nonatomic, strong) HDBaseNVC  *mineNav;


@end

@implementation HDTabBarVC

-(instancetype)initWithViewModel:(HDTabBarViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

-(void)setViewModel:(HDTabBarViewModel *)viewModel{
    _viewModel = viewModel;
    [self configTab];
}

-(void)configTab{
    
    self.viewControllers = [NSArray arrayWithObjects:
                            self.homeNav,
                            self.messageNav,
                            self.mineNav,
                            nil];
    
    self.selectedIndex = [self.viewModel.selectIndex integerValue];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  GET
 *
 *  @return <#return value description#>
 */
- (HDBaseNVC *)homeNav
{
    if (!_homeNav) {
        _homeNav = [[HDBaseNVC alloc] initWithRootViewModel:self.viewModel.homeViewModel];
        _homeNav.tabBarItem.title = @"首页";
        _homeNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_home"];
        _homeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_icon_home_on"];
    }
    return _homeNav;
}
- (HDBaseNVC *)messageNav
{
    if (!_messageNav) {
        _messageNav = [[HDBaseNVC alloc] initWithRootViewModel:self.viewModel.messageViewModel];
        _messageNav.tabBarItem.title=@"动态";
        _messageNav.tabBarItem.image=[UIImage imageNamed:@"tabbar_icon_news"];
        _messageNav.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_icon_news_on"];
    }
    return _messageNav;
}
- (HDBaseNVC *)mineNav
{
    if (!_mineNav) {
        _mineNav = [[HDBaseNVC alloc] initWithRootViewModel:self.viewModel.mineViewModel];
        _mineNav.tabBarItem.title=@"我的";
        _mineNav.tabBarItem.image=[UIImage imageNamed:@"tabbar_icon_mine"];
        _mineNav.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_icon_mine_on"];
    }
    return _mineNav;
}


@end
