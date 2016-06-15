//
//  AppDelegate.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "AppDelegate.h"
#import "LimitedViewController.h"
#import "HotViewController.h"
#import "SubjectViewController.h"
#import "FreeViewController.h"
#import "ReduceViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initlized];
    
    return YES;
}

- (void)initlized
{
    //如果正常情况下此处应该取存储文件中的数据，而不是初始化
    self.favitorArr = [[NSMutableArray alloc] init];
    self.downloadArr = [[NSMutableArray alloc] init];
    self.collectArr = [[NSMutableArray alloc] init];
    
    //创建导航
    LimitedViewController *limited = [[LimitedViewController alloc] init];
    limited.title = @"限免";
    limited.tabBarItem.image = [UIImage imageNamed:@"tabbar_limitfree_press"];
    UINavigationController *limitednv = [[UINavigationController alloc] initWithRootViewController:limited];
    
    ReduceViewController *reduce = [[ReduceViewController alloc]init];
    reduce.title = @"降价";
    reduce.tabBarItem.image = [UIImage imageNamed:@"tabbar_limitfree_press"]
    ;    UINavigationController *reducenv = [[UINavigationController alloc] initWithRootViewController:reduce];
    
    FreeViewController *free = [[FreeViewController alloc] init];
    free.title = @"免费";
    free.tabBarItem.image = [UIImage imageNamed:@"tabbar_appfree_press"];
    UINavigationController *freenv = [[UINavigationController alloc] initWithRootViewController:free];
    
    SubjectViewController *subjict = [[SubjectViewController alloc] init];
    subjict.title = @"专题";
    subjict.tabBarItem.image = [UIImage imageNamed:@"tabbar_subject_press"];
    UINavigationController *subjectnv = [[UINavigationController alloc] initWithRootViewController:subjict];
    
    HotViewController *hot = [[HotViewController alloc] init];
    hot.title = @"热榜";
    hot.tabBarItem.image = [UIImage imageNamed:@"tabbar_rank_press"];
    UINavigationController *hotnv = [[UINavigationController alloc] initWithRootViewController:hot];
    
    
    
    UITabBarController *tablebar = [[UITabBarController alloc] init];
    tablebar.viewControllers = @[limitednv,reducenv,freenv,subjectnv,hotnv];

    self.window.rootViewController = tablebar;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
