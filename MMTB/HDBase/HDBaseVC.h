//
//  HDBaseVC.h
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDBaseViewModel.h"
#import "UITableView+HD.h"
#import "UITableViewCell+HD.h"

@interface HDBaseVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

- (void)HDBindViewModel;

@property (nonatomic, weak)  IBOutlet UITableView *mainTableView;

@property (nonatomic, strong) __kindof HDBaseViewModel *viewModel;

- (instancetype)initWithViewModel:(__kindof HDBaseViewModel *)viewModel;

-(void)setRightBtn:(NSString *)imageName andBlock:(VoidBlock)rightBlock;

@end
