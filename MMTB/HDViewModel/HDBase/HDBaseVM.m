//
//  HDBaseVM.m
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDBaseVM.h"
#import "HDViewModelServicesProtocol.h"
#import "ReactiveCocoa.h"

@interface HDBaseVM ()
@property (nonatomic, copy, readwrite) NSDictionary *params;
@property (nonatomic, strong, readwrite) RACSubject *errors;
@property (nonatomic, strong, readwrite) RACSubject *willDisappearSignal;
@end

@implementation HDBaseVM

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    HDBaseVM *viewModel = [super allocWithZone:zone];
    @weakify(viewModel)
    [[viewModel
      rac_signalForSelector:@selector(initWithServices:params:)]
    	subscribeNext:^(id x) {
            @strongify(viewModel)
            [viewModel initialize];
        }];
    
    return viewModel;
}


- (instancetype)initWithServices:(id<HDViewModelServicesProtocol>)services params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.services = services;
        self.params   = params;
    }
    return self;
}

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (RACSubject *)willDisappearSignal {
    if (!_willDisappearSignal) _willDisappearSignal = [RACSubject subject];
    return _willDisappearSignal;
}

- (void)initialize {}

@end
