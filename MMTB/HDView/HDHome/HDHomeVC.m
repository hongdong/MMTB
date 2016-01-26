//
//  HDHomeVC.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDHomeVC.h"

@interface HDHomeVC ()
@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@end

@implementation HDHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TabarMommyCircleHL"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
