//
//  HDTabBarVC.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDTabBarVC.h"
#import "HDHomeVC.h"
#import "HDMineVC.h"
#import "HDBaseNVC.h"
#import "HDMacrosHeader.h"
#import "UIViewController+HDMVVM.h"

@interface HDTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic, strong) HDHomeVC *homeVC;
@property (nonatomic, strong) HDMineVC *mineVC;

@end

@implementation HDTabBarVC

-(instancetype)init{
    self = [super init];
    if (self) {
        [self configUI];
        [self configTab];
    }
    return self;
}

-(instancetype)initWithViewModel:(HDBaseVM *)vm{
    self = [self init];
    if (self) {
        self.hd_vm = vm;
    }
    return self;
}

-(void)configUI{
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
}

-(void)hd_bindWithViewModel{
    
}

-(void)configTab{
    HDBaseNVC *homeNav = [[HDBaseNVC alloc] initWithRootViewController:self.homeVC];
    [self initTabBarItemImage:homeNav.tabBarItem imagePath:@"TabarHome"];
    homeNav.tabBarItem.title = @"首页";
    
    // 中间
    UIViewController *emptyView = [UIViewController new];
    UIImage *image = [UIImage imageNamed:@"TabarCamera"];
    CGFloat width = image.size.width;
    UIButton *publishButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width)/2, -12,width, width)];
    [publishButton addTarget:self action:@selector(showPublishView) forControlEvents:UIControlEventTouchUpInside];
    [publishButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.tabBar addSubview:publishButton];
    
    HDBaseNVC *minevc = [[HDBaseNVC alloc] initWithRootViewController:self.mineVC];
    minevc.tabBarItem.title = @"我的";
    [self initTabBarItemImage:minevc.tabBarItem imagePath:@"TabarMine"];
    self.viewControllers = @[homeNav, emptyView, minevc];
}

- (void)initTabBarItemImage:(UITabBarItem *)barItem imagePath:(NSString *)path{
    barItem.image = [[UIImage imageNamed:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem.selectedImage = [[UIImage imageNamed:[path stringByAppendingString:@"HL"]]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  GET
 */
- (HDHomeVC *)homeVC{
    if (!_homeVC) {
        _homeVC = [[HDHomeVC alloc] initWithAutoNib];
    }
    return _homeVC;
}
- (HDMineVC *)mineVC{
    if (!_mineVC) {
        _mineVC = [[HDMineVC alloc] initWithAutoNib];
    }
    return _mineVC;
}

@end
