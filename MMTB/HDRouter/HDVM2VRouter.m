//
//  HDVM2VRouter.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDVM2VRouter.h"

@interface HDVM2VRouter ()

@property (nonatomic, copy) NSDictionary *viewModelViewMappings; // viewModel到view的映射

@end

@implementation HDVM2VRouter
HDSingletonM(HDVM2VRouter)

- (HDBaseVC *)viewControllerForViewModel:(HDBaseVM *)viewModel{
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[HDBaseVC class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
    
}

- (NSDictionary *)viewModelViewMappings {
    return @{
             @"MRCLoginViewModel": @"MRCLoginViewController"
             };
}

@end
