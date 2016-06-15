//
//  UIViewController+XSPNetworkRequest.h
//  爱限免
//
//  Created by 夏世萍 on 16/5/16.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XSPNetworkRequest)

- (void)requestMessage:(NSString *)URL parameters:(NSDictionary *)paraneters resultObject:(void (^)(NSDictionary *))result;

@end
