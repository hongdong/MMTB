//
//  HDTableHelper.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDTableHelper.h"

@interface HDTableHelper ()

@property (nonatomic,strong) NSMutableArray<NSMutableArray *> *dataArray;

@property (nonatomic,copy) HDTableHelperCellIdentifierBlock cellIdentifierBlock;

@end

@implementation HDTableHelper
- (void)cellIdentifier:(HDTableHelperCellIdentifierBlock)cb
{
    self.cellIdentifierBlock = cb;
}
#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger curNumOfSections = self.dataArray.count;
    return curNumOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger curNumOfRows = 0;
    if (self.dataArray.count > section) {
        NSMutableArray *subDataAry = self.dataArray[section];
        curNumOfRows = subDataAry.count;
    }
    return curNumOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *curCell = nil;
    id curModel = [self currentModelAtIndexPath:indexPath];
    NSString *curCellIdentifier = [self cellIdentifierForRowAtIndexPath:indexPath model:curModel];
    curCell = [tableView dequeueReusableCellWithIdentifier:curCellIdentifier];
    
    [self sui_configureCell:curCell tableView:tableView atIndexPath:indexPath];
    
    if ([curCell respondsToSelector:@selector(sui_willDisplayWithViewModel:)]) {
        [curCell sui_willDisplayWithViewModel:curCell.sui_vm];
    }
    return curCell;
}

- (NSString *)cellIdentifierForRowAtIndexPath:(NSIndexPath *)cIndexPath model:(id)model
{
    NSString *curCellIdentifier = nil;
    if (self.cellIdentifierBlock) {
        curCellIdentifier = self.cellIdentifierBlock(cIndexPath, model);
    }
    //    else {
    //        NSString *curClassName = NSStringFromClass([cVM class]);
    //        curCellIdentifier = [curClassName sui_regex:@"\\S+(?=VM$)"];
    //    }
    return curCellIdentifier;
}

- (id)currentModel{
    return [self currentModelAtIndexPath:self.hd_selectedIndexPath];
}


- (id)currentModelAtIndexPath:(NSIndexPath *)cIndexPath
{

    if (self.dataArray.count > cIndexPath.section) {
            NSMutableArray *subDataAry = self.dataArray[cIndexPath.section];
            if (subDataAry.count > cIndexPath.row) {
                id curModel = subDataAry[cIndexPath.row];
                return curModel;
            }
    }
    return nil;
}

- (void)sui_configureCell:(UITableViewCell *)cCell tableView:(UITableView *)cTableView atIndexPath:(NSIndexPath *)cIndexPath
{
    id model = [self currentModelAtIndexPath:cIndexPath];
    [cCell.sui_vm bindModel:model];
    
    if ([cCell respondsToSelector:@selector(sui_willCalculateHeightWithViewModel:)]) {
        [cCell sui_willCalculateHeightWithViewModel:cCell.sui_vm];
    }
}



@end
