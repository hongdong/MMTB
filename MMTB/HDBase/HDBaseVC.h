//
//  HDBaseVC.h
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#define HDGetCell(c) [c HDGetCellForTable:tableView indexPath:indexPath viewModel:self.viewModel]
#define HDGetCellHeight(c) [c HDGetCellHeightForTable:tableView indexPath:indexPath viewModel:self.viewModel]
#define HDAutoRegisterGetCell(c) HDRegisterTableCell(c),HDGetCell(c);
#define HDAutoRegisterGetCellHeight(c) HDRegisterTableCell(c),HDGetCellHeight(c);

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
