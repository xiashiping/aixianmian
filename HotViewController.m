//
//  HotViewController.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "HotViewController.h"
#import "BaseTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+XMG.h"
#import "CategoryViewController.h"
#import "detallViewController.h"
#import "settingViewController.h"

#define freeurl @"http://1000phone.net:8088/app/iAppFree/api/hot.php"

@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>
{
    UITableView *HotTableView;
    NSMutableArray *dataArray;
    NSDictionary *info;
    
    
    NSInteger page;   //页数
    UISearchController *serch;
    NSMutableArray *seachArr;  //存储搜索结果的数组
}


@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initlized];
    [self setUI];
    
    
    // Do any additional setup after loading the view.
}

- (void)initlized
{
    page = 0;
    seachArr = [[NSMutableArray alloc] init];
    dataArray = [[NSMutableArray alloc] init];
    [self requestMessage:freeurl parameters:nil];
    
}

- (void)requestMessage:(NSString *)url parameters:(NSDictionary *)parameters
{    
    MBProgressHUD * hud= [MBProgressHUD showMessage:@"玩命加载中"];
    
    page++;
    
    if (parameters == nil)
    {
        parameters = @{@"page":@(page),@"number":@5};
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        info = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (serch.active)
        {
            seachArr = info[@"applications"];
        }
        else
        {
            if (page == 1)
            {
                dataArray = info[@"applications"];
            }
            else
            {
                [dataArray addObjectsFromArray:info[@"applications"]];
            }
            
        }
        [HotTableView reloadData];
        NSLog(@"%@",dataArray);
        [HotTableView.mj_footer endRefreshing];
        [HotTableView.mj_header endRefreshing];
        hud.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}

- (void)setUI
{
    //space空格UIBarButtonItem
    UIBarButtonItem *navigaSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigaSpace.width = -10;
    
    UIButton *leftbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [leftbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftbtn setTitle:@"分类" forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftbtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItems = @[navigaSpace,leftItem];
    
    UIButton *rightbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [rightbtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightbtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItems = @[navigaSpace,rightItem];
    
    //设置标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24],NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:144/255.0 blue:1 alpha:1]}];
    
    //创建TableView
    HotTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    HotTableView.delegate = self;
    HotTableView.dataSource = self;
    [self.view addSubview:HotTableView];
    
    //上拉刷新
    HotTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestMessage:freeurl parameters:nil];
    }];
    
    //下拉刷新
    HotTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [self requestMessage:freeurl parameters:nil];
    }];
    
    
    //添加searchcontroller
    serch = [[UISearchController alloc] initWithSearchResultsController:nil];
    serch.searchResultsUpdater = self;
    serch.searchBar.delegate = self;
    [serch.searchBar sizeToFit];
    serch.searchBar.placeholder = @"请输入搜索内容";
    HotTableView.tableHeaderView = serch.searchBar;
 
}

//btn的触发事件
- (void)leftbtnClicked
{
    CategoryViewController *cvc = [[CategoryViewController alloc] init];
    [self.navigationController showViewController:cvc sender:nil];
}

- (void)rightbtnClicked
{
    settingViewController *svc = [[settingViewController alloc] initWithNibName:@"settingViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController showViewController:svc sender:nil];

}

#pragma mark - searchcontroller
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (serch.searchBar.text.length > 0)
    {
        [self requestMessage:freeurl parameters:@{@"page":@1,@"number":@20,@"search":serch.searchBar.text}];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    serch.active = NO;
    page = 0;
    [self requestMessage:freeurl parameters:nil];
    [HotTableView reloadData];
}


#pragma mark - TableView的协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detallViewController *dvc = [[detallViewController alloc]init];
    dvc.info = dataArray[indexPath.row];
    [self.navigationController showViewController:dvc sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (serch.active)
    {
        return seachArr.count;
    }
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell1";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BaseTableViewCell" owner:nil options:nil] lastObject];
    }
    
    if (serch.active)
    {
        [dataArray removeAllObjects];
        [dataArray addObjectsFromArray:seachArr];
    }
    
    cell.titlelabel.text = dataArray[indexPath.row][@"name"];
    cell.timelabel.text = [NSString stringWithFormat:@"评分:%@分",dataArray[indexPath.row][@"starOverall"]];
    cell.plicelabel.text = [NSString stringWithFormat:@"¥%@.00", dataArray[indexPath.row][@"lastPrice"]];
    cell.gamelabel.text = dataArray[indexPath.row][@"categoryName"];
    cell.sharelabel.text = [NSString stringWithFormat:@"分享:%@",dataArray[indexPath.row][@"shares"]];
    cell.collectionlabel.text = [NSString stringWithFormat:@"收藏:%@",dataArray[indexPath.row][@"favorites"]];
    cell.downlabel.text = [NSString stringWithFormat:@"下载:%@",dataArray[indexPath.row][@"downloads"]];
    
    [cell.iconImgview setImageWithURL:[NSURL URLWithString:dataArray[indexPath.row][@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    CGFloat width = [dataArray [indexPath.row][@"starOverall"]floatValue]/5.0 *68;
    cell.allstar.constant = width;
    
    //价格上的线
    NSAttributedString *butedstr = [[NSAttributedString alloc] initWithString:cell.plicelabel.text attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    cell.plicelabel.attributedText = butedstr;
    
    //    cell.starImgview.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([UIImage imageNamed:@"StarsForeground"].CGImage, CGRectMake(0, 0, cell.starImgview.frame.size.width * 0.5, cell.starImgview.frame.size.height))];
    //    cell.starImgview.frame = CGRectMake(cell.starImgview.frame.origin.x, cell.starImgview.frame.origin.y, cell.starImgview.frame.size.width * 0.5, cell.starImgview.frame.size.height);
    //    cell.starImgview.contentMode = UIViewContentModeScaleAspectFit;
    
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
