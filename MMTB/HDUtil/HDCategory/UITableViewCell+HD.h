//
//  UITableViewCell+HD.h
//  ihealth
//
//  Created by Abner on 16/1/12.
//  Copyright © 2016年 akin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDBaseViewModel;

@interface UITableViewCell (HD)

+(void)HDRegisterForTable:(UITableView*)tableView;

+ (__kindof UITableViewCell *)HDGetCellForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

+ (__kindof UITableViewCell *)HDGetCellForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath viewModel:(__kindof HDBaseViewModel *)viewModel;

+ (CGFloat)HDGetCellHeightForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath viewModel:(__kindof HDBaseViewModel *)viewModel;

+ (CGFloat)HDGetCellHeightForTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration;

@end
