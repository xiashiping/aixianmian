//
//  CategoryViewController.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/16.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "CategoryViewController.h"
#import "UIViewController+XSPNetworkRequest.h"
#import "UIImageView+AFNetworking.h"

@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *CategoryTableView;
    NSMutableArray *dataArr;  //数据源
}
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initlized];
    [self setUI];
    
    // Do any additional setup after loading the view.
}

//初始化数据
- (void)initlized
{
    dataArr = [[NSMutableArray alloc] init];
    [self requestMessage:@"http://1000phone.net:8088/app/iAppFree/api/appcate.php" parameters:nil resultObject:^(NSDictionary *info) {
        NSLog(@"%@",info);
        dataArr = (NSMutableArray *)info;
//        NSLog(@"%@",dataArr);
        //刷新数据
        [CategoryTableView reloadData];
    }];
}


- (void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"限免分类";
    [self createTableView];
}


//创建TableView
- (void)createTableView
{
    CategoryTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    CategoryTableView.dataSource = self;
    CategoryTableView.delegate = self;
    [self.view addSubview:CategoryTableView];
}

#pragma mark - tableview的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.imageView.layer.cornerRadius = 8.0;
    [cell.imageView setImageWithURL:[NSURL URLWithString:dataArr[indexPath.row][@"picUrl"]] placeholderImage:[UIImage imageNamed:@"icon"]];
    cell.textLabel.text = dataArr[indexPath.row][@"categoryCname"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"共%@款应用,其中限免%@款",dataArr[indexPath.row][@"categoryCount"],dataArr[indexPath.row][@"limited"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116;
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
