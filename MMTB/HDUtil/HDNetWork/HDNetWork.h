//
//  HDAPIClient.h
//  ihealth
//
//  Created by 洪东 on 16/1/29.
//  Copyright © 2016年 akin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "AFNetworking.h"
#import "YYCache.h"

static NSString * const HDNetWorkCacheKey = @"HDNetWorkCacheKey";

#define HDPOST(_URL_,_urlParmArr_,_parmDic_) ([[HDNetWork sharedNetWork] HDPOST:[HDAPIUrlManager HDGenerateURLWithPattern:_URL_ parameters:_urlParmArr_] parameters:_parmDic_])

#define HDGET(_URL_,_urlParmArr_,_parmDic_) ([[HDNetWork sharedNetWork] HDGET:[HDAPIUrlManager HDGenerateURLWithPattern:_URL_ parameters:_urlParmArr_] parameters:_parmDic_])

#define HDGETP(_URL_,_urlParmArr_,_parmDic_,_policy_) ([[HDNetWork sharedNetWork] HDGET:[HDAPIUrlManager HDGenerateURLWithPattern:_URL_ parameters:_urlParmArr_] parameters:_parmDic_ policy:_policy_])

#define HDPUT(_URL_,_urlParmArr_,_parmDic_) ([[HDNetWork sharedNetWork] HDPUT:[HDAPIUrlManager HDGenerateURLWithPattern:_URL_ parameters:_urlParmArr_] parameters:_parmDic_])

#define HDDELETE(_URL_,_urlParmArr_,_parmDic_) ([[HDNetWork sharedNetWork] HDDELETE:[HDAPIUrlManager HDGenerateURLWithPattern:_URL_ parameters:_urlParmArr_] parameters:_parmDic_])

typedef NSError *(^ErrorReduceBlock)(NSError *error);
typedef id(^ResponseReduceBlock)(id responseObject);


typedef NS_ENUM(NSUInteger, HDRequestPolicy){
    HDRequestPolicyReturnCacheDataThenLoad = 0,///< 先返回缓存，然后请求数据
    HDRequestPolicyReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    HDRequestPolicyReturnCacheDataElseLoad,///< 有缓存就返回缓存，没有缓存就重新请求(用于数据不变时)
    HDRequestPolicyReturnCacheDataDontLoad,///< 有就返回缓存，没有缓存当做请求出错处理
};


@interface HDNetWork : AFHTTPSessionManager

@property (nonatomic, strong) YYCache *hdCache;

@property (nonatomic, copy) ErrorReduceBlock errorReduceBlock;

@property (nonatomic, copy) ResponseReduceBlock responseReduceBlock;

+ (HDNetWork *)sharedNetWork;

- (RACSignal *)HDGET:(NSString *)URLString parameters:(id)parameters;
- (RACSignal *)HDGET:(NSString *)URLString parameters:(id)parameters policy:(HDRequestPolicy)policy;
- (RACSignal *)HDPOST:(NSString *)URLString parameters:(id)parameters;
- (RACSignal *)HDPUT:(NSString *)URLString parameters:(id)parameters;
- (RACSignal *)HDDELETE:(NSString *)URLString parameters:(id)parameters;


@end