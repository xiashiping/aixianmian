//
//  detallViewController.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/16.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "detallViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIViewController+XSPNetworkRequest.h"
#import "MBProgressHUD+XMG.h"
#import "AppDelegate.h"


@interface detallViewController ()<UIScrollViewDelegate>
{
    UIImageView *imgV1;
    UIImageView *imgV2;
    NSDictionary *requsetDict;
    UIScrollView * imgScroll;
    UILabel *numberLabel;
    UIButton *returnBtn;
    UIButton *collectBtn;
}

@end

@implementation detallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
//    [self setUI];
//    [self creatBtnTitle];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)creatBtnTitle
{
//    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
}

- (void)initData
{
    MBProgressHUD * hud= [MBProgressHUD showMessage:@"正在加载中"];
    //数据请求
    requsetDict = [[NSDictionary alloc] init];
    [self requestMessage:[NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/%@",self.info[@"applicationId"]] parameters:@{@"currency":@"rmb"} resultObject:^(NSDictionary *info) {
        requsetDict = info;
//        xspLog(@"%@",requsetDict);
        [self setUI];
        hud.hidden = YES;
    }];
}

- (void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"应用详情";
    [self createImageview];
    [self createimg1content];
    [self createimg2content];
}

//- (void)setnagation
//{
//    UIButton *leftbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
//    [leftbtn setTitle:@"返回" forState:UIControlStateNormal];
//    [leftbtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
//    [leftbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [leftbtn addTarget:self action:@selector(leftbtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//}
//
//- (void)leftbtnClicked
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}



- (void)createImageview
{
    imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 64 + 5, self.view.bounds.size.width - 10, 400)];
    imgV1.image = [UIImage imageNamed:@"appdetail_background"];
    imgV1.userInteractionEnabled = YES;
    [self.view addSubview:imgV1];
    
   imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 64 + 420, self.view.bounds.size.width - 10, 140)];
    imgV2.image = [UIImage imageNamed:@"appdetail_recommend"];
    imgV2.userInteractionEnabled = YES;
    [self.view addSubview:imgV2];
}

- (void)createimg1content
{
    UIImageView *iconimgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 83, 83)];
    [iconimgV setImageWithURL:[NSURL URLWithString:self.info[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon"]];
    iconimgV.layer.cornerRadius = 15.0;
    [imgV1 addSubview:iconimgV];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(iconimgV.frame.origin.x + 103, iconimgV.frame.origin.y - 10, 200, 40)];
    titlelabel.text = self.info[@"name"];
    titlelabel.font = [UIFont systemFontOfSize:23];
    [imgV1 addSubview:titlelabel];
    
    UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(titlelabel.frame.origin.x, titlelabel.frame.origin.y + 30, 250, 40)];
//    pricelabel.text = @"原价:¥0:00 免费中";
    pricelabel.text = [NSString stringWithFormat:@"原价:¥%@:00 免费中",(NSString *)self.info[@"lastPrice"]];
    pricelabel.textColor = [UIColor lightGrayColor];
    [imgV1 addSubview:pricelabel];
 
    UILabel *competantabellabel = [[UILabel alloc] initWithFrame:CGRectMake(pricelabel.frame.origin.x, pricelabel.frame.origin.y + 25, 120, 40)];
//    competantabellabel.text = @"类型:游戏";
    competantabellabel.text = [NSString stringWithFormat:@"类型:%@",self.info[@"categoryName"]];
    competantabellabel.textColor = [UIColor lightGrayColor];
    [imgV1 addSubview:competantabellabel];
    
    UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(competantabellabel.frame.origin.x +  100, competantabellabel.frame.origin.y, 120, 40)];
//    markLabel.text = @"评分:3.5";
    markLabel.text = [NSString stringWithFormat:@"评分:%@",self.info[@"starOverall"]];
    markLabel.textColor = [UIColor lightGrayColor];
    [imgV1 addSubview:markLabel];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, markLabel.frame.origin.y + 40, imgV1.frame.size.width / 3, 50)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"Detail_btn_left"] forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(sharebtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imgV1 addSubview:shareBtn];
    
    collectBtn = [[UIButton alloc] initWithFrame:CGRectMake(imgV1.frame.size.width / 3, markLabel.frame.origin.y + 40, imgV1.frame.size.width / 3, 50)];
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"Detail_btn_left"] forState:UIControlStateNormal];
    [collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
     [self isselect];
    [collectBtn addTarget:self action:@selector(collectionbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imgV1 addSubview:collectBtn];
    
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake((imgV1.frame.size.width / 3)*2, markLabel.frame.origin.y + 40, imgV1.frame.size.width / 3, 50)];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"Detail_btn_left"] forState:UIControlStateNormal];
    [downloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(downloadbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imgV1 addSubview:downloadBtn];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(shareBtn.frame.origin.x + 10, shareBtn.frame.origin.y + 60, imgV1.frame.size.width - 20, 158)];
//    scroll.backgroundColor = [UIColor blackColor];
    [imgV1 addSubview:scroll];
    
    NSArray *picArr = [NSArray array];
    picArr = requsetDict[@"photos"];
    scroll.contentSize = CGSizeMake(picArr.count * 115 - 5, 158);
    
    for (int i = 0; i < picArr.count; i++)
    {
        NSInteger imageWid = 110;
        NSInteger imageHig = scroll.frame.size.height;
        NSInteger spacing = 5;
        NSInteger X = (imageWid + spacing) * i;
        UIImageView *iconimg = [[UIImageView alloc] initWithFrame:CGRectMake(X, 0, imageWid, imageHig)];
        [iconimg setImageWithURL:[NSURL URLWithString:picArr[i][@"smallUrl"]] placeholderImage:[UIImage imageNamed:@"icon"]];
        iconimg.userInteractionEnabled = YES;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iconimg.frame.size.width, iconimg.frame.size.height)];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [iconimg addSubview:btn];
        [scroll addSubview:iconimg];
    }
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y + 158, scroll.frame.size.width, 70)];
    tv.text = self.info[@"description"];
    tv.font = [UIFont systemFontOfSize:15];
    [tv setTextColor:[UIColor lightGrayColor]];
    tv.backgroundColor = [UIColor clearColor];
    tv.editable = NO;
    [imgV1 addSubview:tv];
}

//btn的触发方法
- (void)sharebtnClicked:(UIButton *)sender
{
    if (sender.selected)
    {
        
    }
    else
    {
        
    }
    
}

- (void)downloadbtnClicked:(UIButton *)sender
{
    if (sender.selected)
    {
        
    }
    else
    {
        
    }

}

- (void)collectionbtnClicked:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"收藏"])
    {
        [((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr addObject:@{@"image":self.info[@"iconUrl"],@"type":limittype,@"title":self.info[@"name"]}];
        [sender setTitle:@"已收藏" forState:UIControlStateNormal];
    }
    else
    {
        NSMutableArray *marr = [NSMutableArray arrayWithArray:((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr];
        for (NSDictionary *dict in marr)
        {
            if ([collectBtn.titleLabel.text isEqualToString:@"已收藏"]&&[dict[@"title"] isEqualToString:self.info[@"name"]])
            {
                [((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr removeObject:dict];
            }
            [sender setTitle:@"收藏" forState:UIControlStateNormal];
        }
    }
//    sender.selected = !sender.selected;
}

- (void)isselect
{
    for (NSDictionary *dict in ((AppDelegate *)[UIApplication sharedApplication].delegate).collectArr)
    {
        if ([dict[@"title"] isEqualToString:self.info[@"name"]])
        {
            collectBtn.selected = YES;
            [collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            return;
        }
    }
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self isselect];
    [super viewWillAppear:animated];
}

- (void)btnClicked:(UIButton *)sender
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    imgScroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    imgScroll.backgroundColor = [UIColor blackColor];
    imgScroll.delegate = self;
    imgScroll.bounces = NO;
    [self.view addSubview:imgScroll];
    
    
    NSArray *picarray = [[NSArray alloc] initWithArray:requsetDict[@"photos"]];
    imgScroll.contentSize =CGSizeMake(self.view.frame.size.width * picarray.count, self.view.frame.size.height);
    for (int i = 0 ; i < picarray.count; i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(imgScroll.frame.size.width * i, imgScroll.frame.origin.y, imgScroll.frame.size.width, imgScroll.frame.size.height)];
        [img setImageWithURL:[NSURL URLWithString:picarray[i][@"originalUrl"]] placeholderImage:[UIImage imageNamed:@"icon"]];
        img.contentMode = UIViewContentModeScaleAspectFit;//按原比例放大
        [imgScroll addSubview:img];
       
        
//        UIImageWriteToSavedPhotosAlbum(img.image, nil, nil, nil);
    }
    returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 20, 60, 30)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [returnBtn setTitle:@"Done" forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 40, 20, 80, 30)];
    numberLabel.text = [NSString stringWithFormat:@"%ld of %ld",sender.tag - 100 + 1,picarray.count];
    [numberLabel setTextColor:[UIColor whiteColor]];
    numberLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:numberLabel];
    
    [imgScroll scrollRectToVisible:CGRectMake((sender.tag - 100) * imgScroll.frame.size.width, 0, imgScroll.frame.size.width, imgScroll.frame.size.height) animated:YES];
   
}

- (void)returnBtnClicked
{
    [imgScroll removeFromSuperview];
    numberLabel = nil;
    returnBtn = nil;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)createimg2content
{
    
    NSArray *picArr = [NSArray array];
    picArr = requsetDict[@"photos"];
    
    for (int i = 0; i < 4; i++)
    {
        NSInteger buttonWid = 80;
        NSInteger buttonHig = 130;
        NSInteger number = 4;
        NSInteger spacing = ((imgV2.frame.size.width - 20) - (number * buttonWid)) / number;
        NSInteger index = imgV2.subviews.count;
        NSInteger X = (buttonWid + spacing) * index + 20;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(X, 25, buttonWid, buttonHig)];
        [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, buttonWid, buttonWid)];
        image.layer.cornerRadius = 15.0;
        [image setImageWithURL:[NSURL URLWithString:picArr[i][@"smallUrl"]] placeholderImage:[UIImage imageNamed:@"icon"]];
//        image.image = [UIImage imageNamed:@"icon"];
        [button addSubview:image];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, image.frame.size.width - 5, buttonWid, buttonHig - image.frame.size.height)];
        label.text = @"不开心";
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        [imgV2 addSubview:button];
    }
}

- (void)buttonClicked
{
    xspLog(@"胡姐美少女");
}


#pragma mark scrollview的协议方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int page = (scrollView.contentOffset.x - scrollView.frame.size.width / 2)/scrollView.frame.size.width + 1;
    numberLabel.text = [NSString stringWithFormat:@"%d of %d",page + 1,(int)(imgScroll.contentSize.width/imgScroll.frame.size.width)];
    [imgScroll scrollRectToVisible:CGRectMake(scrollView.frame.size.width * page, 0 , scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x - scrollView.frame.size.width / 2)/scrollView.frame.size.width + 1;
    numberLabel.text = [NSString stringWithFormat:@"%d of %d",page + 1,(int)(imgScroll.contentSize.width/imgScroll.frame.size.width)];
    [imgScroll scrollRectToVisible:CGRectMake(scrollView.frame.size.width * page, 0 , scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
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
