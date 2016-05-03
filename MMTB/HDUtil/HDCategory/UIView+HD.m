//
//  UIView+HD.m
//  djBI
//
//  Created by 洪东 on 2/24/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "UIView+HD.h"
#import "HDCommonHeader.h"

@implementation UIView (HD)
- (void)resetAllView{
    // 等比例缩放约束
    NSArray *constraints = self.constraints;
    if(constraints && constraints.count > 0){
        for(NSLayoutConstraint *constraint in constraints){
            constraint.constant = GET(constraint.constant);
        }
    }
    
    // 若是Label缩放font
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label = (UILabel *)self;
        NSString *fontName = label.font.fontName;
        CGFloat size = label.font.pointSize;
        label.font = [UIFont fontWithName:fontName size:GET(size)];
    }
    
    // 若是按钮
    if([self isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton *)self;
        NSString *fontName = button.titleLabel.font.fontName;
        CGFloat size = button.titleLabel.font.pointSize;
        
        button.titleLabel.font = [UIFont fontWithName:fontName size:GET(size)];
    }
    
    // 若存在subViews 同样进行缩放操作
    NSArray *subViews = self.subviews;
    if(!subViews || subViews.count == 0){
        return;
    }
    
    for(UIView *view in subViews){
        [view resetAllView];
    }
}

// 把所有需要宽度为0.5的Line设置自动设置
- (void)resetLineView{
    if(self.tag == 2502){
        for(NSLayoutConstraint *constraint in self.constraints){
            if(constraint.constant == 1){
                
                constraint.constant = 1/HDSCREEN_SCALE;
            }
        }
    }
    
    // 若存在subViews 同样进行缩放操作
    NSArray *subViews = self.subviews;
    if(!subViews || subViews.count == 0){
        return;
    }
    
    for(UIView *subView in subViews){
        [subView resetLineView];
    }
}

//设置圆角
- (void)changeToCircle{
    //    view.layer.shouldRasterize = YES;
    //    view.layer.rasterizationScale = view.window.screen.scale;
    [self.layer setMasksToBounds:YES];
    [self setCornerRadius:GET(CGHeight(self.frame))/2];
}

- (void)setCornerRadius:(CGFloat)radius{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}


@end
