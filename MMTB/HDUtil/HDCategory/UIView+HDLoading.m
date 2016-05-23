//
//  UIView+HDLoading.m
//  MMTB
//
//  Created by 洪东 on 5/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "UIView+HDLoading.h"
#import <objc/runtime.h>

static char IndicatorViewKey;

@implementation UIView (HDLoading)
#pragma mark indicatorView
- (void)setIndicatorView:(UIActivityIndicatorView *)indicatorView{
    [self willChangeValueForKey:@"IndicatorViewKey"];
    objc_setAssociatedObject(self, &IndicatorViewKey,
                             indicatorView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"IndicatorViewKey"];
}

- (UIActivityIndicatorView *)indicatorView{
    return objc_getAssociatedObject(self, &IndicatorViewKey);
}

-(void)HDBeginLoading{
    if (!self.indicatorView) {
        self.indicatorView = [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGSize captchaViewSize = self.bounds.size;
        self.indicatorView.hidesWhenStopped = YES;
        [self.indicatorView setCenter:CGPointMake(captchaViewSize.width/2, captchaViewSize.height/2)];
        [self addSubview:self.indicatorView];
    }
    [self.indicatorView startAnimating];
    [self setUserInteractionEnabled:NO];
}

-(void)HDEndLoading{
    if (self.indicatorView&&self.indicatorView.isAnimating) {
        [self.indicatorView stopAnimating];
        [self setUserInteractionEnabled:YES];
        self.indicatorView = nil;
    }

}

@end
