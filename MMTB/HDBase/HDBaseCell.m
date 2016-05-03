//
//  HDBaseCell.m
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDBaseCell.h"
#import "UIView+HD.h"

@implementation HDBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView resetLineView];
    [self.contentView resetAllView];
}

-(void)bindViewModel:(HDBaseViewModel *)viewModel indexPath:(NSIndexPath *)indexPath{
    if (!viewModel) {
        return;
    }
    _viewModel = viewModel;
    _indexPath = indexPath;
    [self HDFillData];
}

-(void)HDFillData{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
