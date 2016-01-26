//
//  HDBaseVM.h
//  MMTB
//
//  Created by 洪东 on 16/1/26.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HDViewModelServicesProtocol;

@interface HDBaseVM : NSObject

@property (nonatomic, strong) id<HDViewModelServicesProtocol> services;

- (instancetype)initWithServices:(id<HDViewModelServicesProtocol>)services params:(NSDictionary *)params;

- (void)initialize;


@end
