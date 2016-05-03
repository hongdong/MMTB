//
//  HDBaseViewModel.m
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import "HDBaseViewModel.h"
#import "HDBaseVC.h"

@interface HDBaseViewModel ()
@property (nonatomic, strong, readwrite) RACSubject *errors;
@property (nonatomic, strong, readwrite) RACSubject *showHUDSignal;
@property (nonatomic, strong, readwrite) RACSubject *dismissHUDSignal;
@property (nonatomic, strong, readwrite) RACSubject *willDisappearSignal;
@end

@implementation HDBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    HDBaseViewModel *viewModel = [super allocWithZone:zone];
    
    @weakify(viewModel)
    
    [[viewModel
      rac_signalForSelector:@selector(initWithParams:)]
    	subscribeNext:^(id x) {
            @strongify(viewModel)
            [viewModel HDInitialize];
        }];
    
    return viewModel;
}

- (instancetype)initWithParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
        if (params) {
            [self setValuesForKeysWithDictionary:params];
        }
    }
    return self;
}

- (__kindof HDBaseVC *)routerVC{
    
    NSString * className = [[[NSStringFromClass([self class]) componentsSeparatedByString:@"iewModel"] firstObject] stringByAppendingString:@"C"];
    
    NSParameterAssert([NSClassFromString(className) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(className) alloc] initWithViewModel:self];
    
}


- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (RACSubject *)showHUDSignal{
    if (!_showHUDSignal) {
        _showHUDSignal = [RACSubject subject];
    }
    return _showHUDSignal;
}

- (RACSubject *)dismissHUDSignal{
    if (!_dismissHUDSignal) {
        _dismissHUDSignal = [RACSubject subject];
    }
    return _dismissHUDSignal;
}

- (RACSubject *)willDisappearSignal {
    if (!_willDisappearSignal) _willDisappearSignal = [RACSubject subject];
    return _willDisappearSignal;
}

- (void)HDInitialize{
    
}

@end
