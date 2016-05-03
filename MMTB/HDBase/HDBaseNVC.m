//
//  HDBaseNVC.m
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDBaseNVC.h"
#import "UINavigationController+JZExtension.h"
#import "HDTHEMEConfig.h"
#import "HDBaseViewModel.h"

@interface HDBaseNVC ()

@end

@implementation HDBaseNVC

-(instancetype)initWithRootViewModel:(HDBaseViewModel *)viewModel{
    self = [super initWithRootViewController:[viewModel routerVC]];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.jz_fullScreenInteractivePopGestureEnabled = YES;
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.barTintColor = HDTHEME_COLOR;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    
    // 清除边框
    for (UIView *view in self.navigationBar.subviews){
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]){
            for (UIView *subView in view.subviews){
                if ([subView isKindOfClass:[UIImageView class]]){
                    [subView removeFromSuperview];
                    
                    break;
                }
            }
            
            break;
        }
    }
    
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

@end
