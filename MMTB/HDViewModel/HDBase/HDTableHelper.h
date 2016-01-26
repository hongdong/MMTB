//
//  HDTableHelper.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * __nonnull (^HDTableHelperCellIdentifierBlock)(NSIndexPath *cIndexPath, id model);
@interface HDTableHelper : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSIndexPath *hd_selectedIndexPath;


- (void)cellIdentifier:(HDTableHelperCellIdentifierBlock)cb;

@end
NS_ASSUME_NONNULL_END