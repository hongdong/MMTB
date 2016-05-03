//
//  UITableViewCell+HD.m
//  ihealth
//
//  Created by Abner on 16/1/12.
//  Copyright © 2016年 akin. All rights reserved.
//

#import "UITableViewCell+HD.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HDBaseCell.h"
#import "UITableView+HD.h"
@implementation UITableViewCell (HD)

+ (void)HDRegisterForTable:(UITableView *)tableView{
    
    NSString *cellIdentifier = NSStringFromClass([self class]);

    if (!tableView.tableViewRegisterCell[cellIdentifier]) {//如果没有注册过
        UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        [tableView.tableViewRegisterCell setValue:@(YES) forKey:cellIdentifier];
    }

}

+ (__kindof UITableViewCell *)HDGetCellForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath viewModel:(__kindof HDBaseViewModel *)viewModel{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    HDBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell HDBindViewModel:viewModel indexPath:indexPath];
    return cell;
}

+ (__kindof UITableViewCell *)HDGetCellForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    return [self HDGetCellForTable:tableView indexPath:indexPath viewModel:nil];
}

+ (CGFloat)HDGetCellHeightForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration {
    NSString *cellIdentifier = NSStringFromClass([self class]);
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:configuration];
}

+ (CGFloat)HDGetCellHeightForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath viewModel:(__kindof HDBaseViewModel *)viewModel{
    return [self HDGetCellHeightForTable:tableView indexPath:indexPath configuration:^(HDBaseCell *cell) {
        [cell HDBindViewModel:viewModel indexPath:indexPath];
    }];
}


@end
