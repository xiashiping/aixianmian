//
//  UIViewController+XSPNetworkRequest.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/16.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "UIViewController+XSPNetworkRequest.h"
#import "AFNetworking.h"

@implementation UIViewController (XSPNetworkRequest)

- (void)requestMessage:(NSString *)URL parameters:(NSDictionary *)paraneters resultObject:(void (^)(NSDictionary *))result
{
    __block NSDictionary *dict = [[NSDictionary alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       if (paraneters == nil)
    {
        paraneters = @{@"page":@1,@"number":@5};
    }
    [manager GET:URL parameters:paraneters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        result(dict);
    } failure:nil];
}

@end
