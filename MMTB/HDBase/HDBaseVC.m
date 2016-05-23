//
//  HDBaseVC.m
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDBaseVC.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "UIView+HDLoading.h"
#import "UIBarButtonItem+BlocksKit.h"
#import "HDCommonHeader.h"

@interface HDBaseVC ()

@end

@implementation HDBaseVC

-(void)setRightBtn:(NSString *)imageName andBlock:(VoidBlock)rightBlock{
    UIBarButtonItem *marginItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    marginItem.width = -4;
    UIBarButtonItem *rightItem = [UIBarButtonItem new];
    [rightItem bk_initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain handler:^(id sender) {
        if (rightBlock) {
            rightBlock();
        }
    }];
    self.navigationItem.rightBarButtonItems = @[marginItem, rightItem];
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    HDBaseVC *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController HDBindViewModel];
     }];
    
    return viewController;
}

- (HDBaseVC *)initWithViewModel:(HDBaseViewModel *)viewModel {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.viewModel = viewModel;

        if (self) {
            if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
                @weakify(self)
                [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
                    @strongify(self)
                    if (self.viewModel.requestRemoteDataCommand) {
                        [self.viewModel.requestRemoteDataCommand execute:nil];
                    }
                }];
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.navigationController.navigationBar setBarTintColor:THEME_COLOR];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.extendedLayoutIncludesOpaqueBars = YES;
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@""
                                style:UIBarButtonItemStylePlain
                                target:nil
                                action:nil];
    self.navigationItem.backBarButtonItem=btnBack;
    
    [self configTableView];
    
}

- (void)configTableView{
    @weakify(self)
    
    if (self.viewModel.shouldPullToRefresh) {
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            if (self.viewModel.requestRemoteDataCommand) {
                [[[self.viewModel.requestRemoteDataCommand
                   execute:@1]
                  deliverOnMainThread]
                 subscribeNext:^(id x) {
                     
                 } error:^(NSError *error) {
                     @strongify(self)
                     if ([self.mainTableView.mj_header isRefreshing]) {
                         [self.mainTableView.mj_header endRefreshing];
                     }
                 } completed:^{
                     @strongify(self)
                     if ([self.mainTableView.mj_header isRefreshing]) {
                         [self.mainTableView.mj_header endRefreshing];
                     }
                 }];
            }
            
            if (self.viewModel.pullFreshActionBlock) {
                self.viewModel.pullFreshActionBlock();
            }
            
        }];
        
    }
    
    if (self.viewModel.shouldPullToLoadMore) {
        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            if (self.viewModel.requestRemoteDataCommand) {
                [[[self.viewModel.requestRemoteDataCommand
                   execute:nil]
                  deliverOnMainThread]
                 subscribeNext:^(NSArray *results) {
                     
                 } error:^(NSError *error) {
                     @strongify(self)
                     if ([self.mainTableView.mj_footer isRefreshing]) {
                         [self.mainTableView.mj_footer endRefreshing];
                     }
                     
                 } completed:^{
                     @strongify(self)
                     if ([self.mainTableView.mj_footer isRefreshing]) {
                         [self.mainTableView.mj_footer endRefreshing];
                     }
                 }];

            }
            
            if (self.viewModel.pullLoadMoreActionBlock) {
                self.viewModel.pullLoadMoreActionBlock();
            }

            
        }];
    }
    
//    self.mainTableView.tableFooterView = [[UIView alloc] init];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
}

- (void)HDBindViewModel {
    @weakify(self);
    
    [[RACObserve(self.viewModel, shouldEndEdit) filter:^BOOL(id value) {
        if ([value boolValue]) {
            return YES;
        }else{
            return NO;
        }
    }] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
    }];
    
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"Message"]];
        [self.view HDEndLoading];
    }];
    
    [self.viewModel.showHUDSignal subscribeNext:^(id x) {
        if (!HDStrIsEmptyOrNil(x)) {
            [SVProgressHUD showWithStatus:x];
        }else{
            [SVProgressHUD dismiss];
        }
    }];

    
    [self.viewModel.showHUDSignal subscribeNext:^(id x) {
        [SVProgressHUD showWithStatus:x];
    }];
    
    [RACObserve(self.viewModel, fullScreenLoading) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.view HDBeginLoading];
        }else{
            [self.view HDEndLoading];
        }
    }];

    //dataArr被重新赋值以后的处理
    [[RACObserve(self.viewModel, dataArr)
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.mainTableView reloadData];
     }];
}

/**
 *  table代理
 *
 *  @param animated
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%@",HDString(@"%@类没有实现numberOfSectionsInTableView方法,返回默认dataArr.count",NSStringFromClass([self class])));
    return self.viewModel.dataArr.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%@",HDString(@"%@类没有实现numberOfRowsInSection方法,返回默认dataArr[section] count",NSStringFromClass([self class])));
    if ([self.viewModel.dataArr[section] isKindOfClass:[NSArray class]]) {
        return [self.viewModel.dataArr[section] count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",HDString(@"ERROR--------%@类没有实现cellForRowAtIndexPath方法",NSStringFromClass([self class])));
    return nil;
}

//-------------//

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewModel.willDisappearSignal sendNext:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _mainTableView.dataSource = nil;
    _mainTableView.delegate = nil;
}


@end
