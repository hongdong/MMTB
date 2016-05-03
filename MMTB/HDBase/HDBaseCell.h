//
//  HDBaseCell.h
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDBaseViewModel;
@interface HDBaseCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) __kindof HDBaseViewModel *viewModel;
-(void)bindViewModel:(__kindof HDBaseViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;
-(void)HDFillData;
@end
