//
//  HDBaseViewModel.h
//  djBI
//
//  Created by 洪东 on 2/23/16.
//  Copyright © 2016 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "HDCommonHeader.h"

@class HDBaseVC;

@interface HDBaseViewModel : NSObject

- (instancetype)initWithParams:(NSDictionary *)params;

- (instancetype)initWithBlock:(VoidBlock_id)block;

- (void)HDInitialize;

- (__kindof HDBaseVC *)routerVC;

@property (nonatomic, strong, readonly) RACSubject *errors;

@property (nonatomic, strong, readonly) RACSubject *showHUDSignal;

@property (nonatomic, strong, readonly) RACSubject *dismissHUDSignal;

@property (nonatomic, assign) BOOL shouldRequestRemoteDataOnViewDidLoad;

@property (nonatomic, assign) BOOL shouldEndEdit;

@property (nonatomic, assign) BOOL fullScreenLoading;

@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

@property (nonatomic, strong) RACCommand *requestRemoteDataCommand;

@property (nonatomic, assign) BOOL shouldPullToRefresh;

@property (nonatomic, copy) VoidBlock pullFreshActionBlock;

@property (nonatomic, assign) BOOL shouldPullToLoadMore;

@property (nonatomic, copy) VoidBlock pullLoadMoreActionBlock;


@property (nonatomic, copy) NSArray *dataArr;

@property (nonatomic, copy) NSArray *sourceDataArr;

@property (nonatomic, strong) NSString *keyword;

@end
