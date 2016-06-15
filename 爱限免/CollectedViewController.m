//
//  CollectedViewController.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/19.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "CollectedViewController.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"

@interface CollectedViewController ()
{
    UIButton *rightbtn;
}

@end

@implementation CollectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    // Do any additional setup after loading the view.
}

- (void)setUI
{
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *navigaSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigaSpace.width = -10;
    
    UIButton *leftbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [leftbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftbtn setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    [leftbtn addTarget:self action:@selector(leftbtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItems = @[navigaSpace,leftItem];
    
    rightbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_edit"] forState:UIControlStateNormal];
    [rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    [rightbtn addTarget:self action:@selector(rightbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[navigaSpace,rightItem];
    
    [self createCollectedcontent];
}

//创建收藏的内容
- (void)createCollectedcontent
{
    NSMutableArray *arr = ((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr;
    //空格的宽度
    CGFloat spacewidth = (self.view.bounds.size.width - 3 * 75) / 4;
    for (int i = 0 ; i < arr.count; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(spacewidth * (i % 3 + 1) + 75 * (i % 3), 64 + spacewidth * (i / 3 + 1) + 75 * (i / 3), 75, 75)];
        view.tag = 200 + i;
        view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(9, 6, 57, 57)];
        [img setImageWithURL:[NSURL URLWithString:arr[i][@"image"]] placeholderImage:[UIImage imageNamed:@"icon"]];
        img.layer.cornerRadius = 8.0;
        [view addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 75, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.text = arr[i][@"title"];
        [view addSubview:label];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(-3, -6, 24, 24)];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        closeBtn.tag = 300 + i;
        [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.hidden = YES;
        [view addSubview:closeBtn];
    }
}

- (void)closeBtnClicked:(UIButton *)sender
{
     UIView *foreview = [self.view viewWithTag:sender.tag - 100];
    [foreview removeFromSuperview];
    CGFloat spacewidth = (self.view.bounds.size.width - 3 * 75) / 4;
    
    for (int i = 0; i < ((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr.count - (sender.tag - 300) - 1; i++)
    {
       
        UIView *view = [[UIView alloc] init];
        view = [self.view viewWithTag:sender.tag - 100 + 1 + i];
        view.tag = view.tag - 1;
        UIButton *btn = [view viewWithTag:sender.tag + 1 + i];
        btn.tag = btn.tag - 1;
        NSLog(@"%ld,%ld",view.tag,btn.tag);
        [UIView animateWithDuration:(i + 1) * 0.5 animations:^{
            
            view.frame = CGRectMake(spacewidth * ((sender.tag - 300 + i) % 3 + 1) + 75 * ((sender.tag - 300 + i) % 3), 64 + spacewidth * ((sender.tag - 300 + i) / 3 + 1) + 75 * ((sender.tag - 300 + i) / 3), 75, 75);
            NSLog(@"%f",view.frame.origin.x);
            
        } completion:^(BOOL finished) {
            
        }];
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr removeObjectAtIndex:sender.tag - 300];
        
    }
}

- (void)leftbtnClicked
{
    //返回上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightbtnClicked:(UIButton *)sender
{
    if (!sender.selected)
    {
        [rightbtn setTitle:@"完成" forState:UIControlStateNormal];
        for (UIView *view in [self.view subviews])
        {
            if (view.tag >= 200)
            {
                for (UIButton *btn in [view subviews])
                {
                    if (btn.tag >= 300)
                    {
                        btn.hidden = NO;
                    }
                }
            }
        }
    }
    else
    {
        [rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
        for (UIView *view in [self.view subviews])
        {
            if (view.tag >= 200)
            {
                for (UIButton *btn in [view subviews])
                {
                    if (btn.tag >= 300)
                    {
                         btn.hidden = YES;
                    }
                }
            }
        }

    }
    sender.selected = !sender.selected;
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

@end
