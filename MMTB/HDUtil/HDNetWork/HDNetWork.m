//
//  HDAPIClient.m
//  ihealth
//
//  Created by 洪东 on 16/1/29.
//  Copyright © 2016年 akin. All rights reserved.
//



#import "HDNetWork.h"
#import "HDCommonHeader.h"
#import "HDTHEMEConfig.h"

NSString *const RACAFNResponseObjectErrorKey = @"responseObject";


@interface HDNetWork (RACSupport)
/// A convenience around -GET:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters;
- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters policy:(HDRequestPolicy)policy;
/// A convenience around -HEAD:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters;

/// A convenience around -POST:parameters:success:failure: that returns a cold signal of the
/// result.
- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters;

/// A convenience around -POST:parameters:constructingBodyWithBlock:success:failure: that returns a
/// cold signal of the resulting JSON object and response headers or error.
- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block;

/// A convenience around -PUT:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters;

/// A convenience around -PATCH:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters;

/// A convenience around -DELETE:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters;

@end

@implementation HDNetWork (RACSupport)

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"GET"]
            setNameWithFormat:@"%@ -rac_GET: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters policy:(HDRequestPolicy)policy{
    return [[self rac_requestPath:path parameters:parameters method:@"GET" policy:policy]
            setNameWithFormat:@"%@ -rac_GET: %@, parameters: %@", self.class, path, parameters];
}


- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"HEAD"]
            setNameWithFormat:@"%@ -rac_HEAD: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"POST"]
            setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block {
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
        
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                if (responseObject) {
                    userInfo[RACAFNResponseObjectErrorKey] = responseObject;
                }
                NSError *errorWithRes = [NSError errorWithDomain:error.domain code:error.code userInfo:[userInfo copy]];
                [subscriber sendError:errorWithRes];
            } else {
                [subscriber sendNext:RACTuplePack(responseObject, response)];
                [subscriber sendCompleted];
            }
        }];
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@, constructingBodyWithBlock:", self.class, path, parameters];
    ;
}

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"PUT"]
            setNameWithFormat:@"%@ -rac_PUT: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"PATCH"]
            setNameWithFormat:@"%@ -rac_PATCH: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"DELETE"]
            setNameWithFormat:@"%@ -rac_DELETE: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_requestPath:(NSString *)path parameters:(id)parameters method:(NSString *)method policy:(HDRequestPolicy)policy{
    
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        RACDisposable * (^doRequest)(NSString *urlKey) = ^(NSString *urlKey){
            NSURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
//            request = [[[request mutableCopy] HDAddUserAuth] copy];
            NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                    if (responseObject) {
                        userInfo[RACAFNResponseObjectErrorKey] = responseObject;
                    }
                    NSError *errorWithRes = [NSError errorWithDomain:error.domain code:error.code userInfo:[userInfo copy]];
                    [subscriber sendError:errorWithRes];
                } else {
                    RACTuple *resultTuple = RACTuplePack(responseObject, response);
                    [subscriber sendNext:resultTuple];
                    if (urlKey) {
                        [self.hdCache setObject:resultTuple forKey:urlKey];
                    }
                    [subscriber sendCompleted];
                }
            }];
            [task resume];
            
            return [RACDisposable disposableWithBlock:^{
                [task cancel];
            }];
            
        };
        
        if ([method isEqualToString:@"GET"]) {
            NSString *urlKey = [path stringByAppendingString:[self serializeParams:parameters]];
            id result = [self.hdCache objectForKey:urlKey];
            switch (policy) {
                case HDRequestPolicyReturnCacheDataThenLoad:
                {
                    if (result) {
                        [subscriber sendNext:result];
                    }
                    return doRequest(urlKey);
                    break;
                }
                case HDRequestPolicyReloadIgnoringLocalCacheData:
                {
                    return doRequest(urlKey);
                    break;
                }
                case HDRequestPolicyReturnCacheDataElseLoad:
                {
                    if (result) {
                        [subscriber sendNext:result];
                        [subscriber sendCompleted];
                        return [RACDisposable disposableWithBlock:^{
                            
                        }];
                    }else{
                        return doRequest(urlKey);
                    }
                    break;
                }
                case HDRequestPolicyReturnCacheDataDontLoad:
                {
                    if (result) {
                        [subscriber sendNext:result];
                        [subscriber sendCompleted];
                        return [RACDisposable disposableWithBlock:^{
                            
                        }];
                    }else{
                        NSError *error = [NSError errorWithDomain:@"abner" code:444 userInfo:nil];
                        [subscriber sendError:error];
                        return [RACDisposable disposableWithBlock:^{
                            
                        }];
                    }
                    break;
                }
                default:{
                    return [RACDisposable disposableWithBlock:^{
                        
                    }];
                    break;
                }
            }
        }else{
            return doRequest(nil);
        }
    }];
}

- (RACSignal *)rac_requestPath:(NSString *)path parameters:(id)parameters method:(NSString *)method {
    return [self rac_requestPath:path parameters:parameters method:method policy:HDRequestPolicyReloadIgnoringLocalCacheData];
}
/**
 *  参数序列化
 *
 *  @param params params 参数
 *
 *  @return return value 参数字符串
 */

-(NSString *)serializeParams:(NSDictionary *)params {
    NSMutableArray *parts = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id<NSObject> obj, BOOL *stop) {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *encodedValue = [obj.description stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject: part];
    }];
    NSString *queryString = [parts componentsJoinedByString: @"&"];
    return queryString ? [NSString stringWithFormat:@"?%@", queryString] : @"";
}


@end


@interface HDNetWork ()

@end

@implementation HDNetWork

+(HDNetWork *)sharedNetWork {
    static HDNetWork *_sharedNetWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetWork = [[HDNetWork alloc] initWithBaseURL:[NSURL URLWithString:HTTP_SERVER]];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        _sharedNetWork.securityPolicy = securityPolicy;
        _sharedNetWork.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        _sharedNetWork.hdCache = [[YYCache alloc] initWithName:HDNetWorkCacheKey];
        _sharedNetWork.hdCache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
        _sharedNetWork.hdCache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
        
        
//        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
//        
//        _sharedClient.responseSerializer.acceptableContentTypes = [_sharedClient.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
    });
    return _sharedNetWork;
}

- (RACSignal *)HDGET:(NSString *)URLString parameters:(id)parameters policy:(HDRequestPolicy)policy{
    return [self HDRequest:URLString parameters:parameters method:@"GET" policy:policy];
}

- (RACSignal *)HDGET:(NSString *)URLString parameters:(id)parameters {
    return [self HDRequest:URLString parameters:parameters method:@"GET"];
}

- (RACSignal *)HDPOST:(NSString *)URLString parameters:(id)parameters{
    return [self HDRequest:URLString parameters:parameters method:@"POST"];
}

- (RACSignal *)HDPUT:(NSString *)URLString parameters:(id)parameters{
    return [self HDRequest:URLString parameters:parameters method:@"PUT"];
}

- (RACSignal *)HDDELETE:(NSString *)URLString parameters:(id)parameters{
    return [self HDRequest:URLString parameters:parameters method:@"DELETE"];
}

- (RACSignal *)HDRequest:(NSString *)URLString parameters:(id)parameters method:(NSString *)method {
    return [self HDRequest:URLString parameters:parameters method:method policy:HDRequestPolicyReloadIgnoringLocalCacheData];
}

- (RACSignal *)HDRequest:(NSString *)URLString parameters:(id)parameters method:(NSString *)method policy:(HDRequestPolicy)policy{
    
    DebugLog(@"\n===========%@请求参数===========\n%@:\n%@", method, URLString, parameters);

    RACSignal *signal = [RACSignal empty];
    if ([method isEqualToString:@"GET"]) {
        signal = [self rac_GET:URLString parameters:parameters policy:policy];
    }else if ([method isEqualToString:@"POST"]) {
        signal = [self rac_POST:URLString parameters:parameters];
    }else if ([method isEqualToString:@"PUT"]) {
        signal = [self rac_PUT:URLString parameters:parameters];
    }else if ([method isEqualToString:@"DELETE"]) {
        signal = [self rac_DELETE:URLString parameters:parameters];
    }else{
        
    }
    
    return [[signal catch:^RACSignal *(NSError *error) {
        //对Error进行处理
        DebugLog(@"\n===========%@返回错误===========\n%@:\n%@",method, URLString, error);
        //TODO: 这里可以根据error.code来判断下属于哪种网络异常，分别给出不同的错误提示
        
        return  [RACSignal error:self.errorReduceBlock?self.errorReduceBlock(error):error];
        
    }] reduceEach:^id(id responseObject, NSURLResponse *response){
        DebugLog(@"\n===========%@返回结果===========\n%@:\n%@",method, URLString, responseObject);
        
        return self.responseReduceBlock?self.responseReduceBlock(responseObject):responseObject;
        
    }];
}

@end
