//
//  settingViewController.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/19.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "settingViewController.h"
#import "AppDelegate.h"
#import "CollectedViewController.h"

@interface settingViewController ()
- (IBAction)collectBtnClicked:(id)sender;

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置详情";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *title = [NSString stringWithFormat:@"%ld",((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr.count];
    [self.collectionBtn setTitle:title forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)collectBtnClicked:(id)sender
{
    CollectedViewController *cvc = [[CollectedViewController alloc] init];
    [self.navigationController showViewController:cvc sender:nil];
}
@end
