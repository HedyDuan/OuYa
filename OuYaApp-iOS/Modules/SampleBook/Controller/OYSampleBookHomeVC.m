//
//  OYSampleBookHomeVC.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/15.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookHomeVC.h"
#import "OYSampleBookHomeCell.h"
#import "OYSampleBookListVC.h"
#import "OYSampleBookHomeModel.h"
#import "AppDelegate.h"
#import "OYLoginViewController.h"

@interface OYSampleBookHomeVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat cellheight;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewwidth;

@end

@implementation OYSampleBookHomeVC
+ (OYSampleBookHomeVC *)shareViewController {
    OYSampleBookHomeVC *mainCtrl =
    [UIStoryboard showControllerWithStoryBoardName:@"SampleBook" VCIdentifier:[OYSampleBookHomeVC className]];
    return mainCtrl;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.bottomHeight.constant = 120 * Radio_Y;
    self.bottomLeft.constant = 343 * Radio_X;
    self.tableviewwidth.constant = 844 * Radio_X;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (!kStringIsEmpty([defaults objectForKey:AccountKey]) && !kStringIsEmpty([defaults objectForKey:PwdKey])) {
       //不操作
    }else{
        [self gotoLoginVc];
        return;
    }
  
    self.view.backgroundColor = [UIColor colorForHex:0xededed];

    [self setTableViewApperence];
    self.view.backgroundColor = [UIColor colorForHex:0xededed];
    self.titleText = @"产品馆";
    [self getData];
}

//网络请求
- (void)getData{
    [GLHUD showHUD];
    NSString * sessionid = [[NSUserDefaults standardUserDefaults] objectForKey:SessionIdKey];
    NSString * userid = [[NSUserDefaults standardUserDefaults] objectForKey:UserIdKey];
    NSDictionary * dict = @{@"sessionId":sessionid,@"userId":[NSNumber numberWithLong:[userid integerValue]]};
    [PPNetworkHelper POST:@"http://120.55.171.114:8088/api/user/searchAllBook.do" parameters:dict success:^(id responseObject) {
        [GLHUD hideHUD];
        NSLog(@"responseObject==========%@",responseObject);
        NSDictionary * dict = responseObject;
        if (responseObject[@"success"]) {
            if ([dict[@"resultCode"] integerValue] == 1000) {
                [self dealResponseDataWithDictionary:dict];
            }else if ([dict[@"resultCode"] integerValue] == 2001){
                [MFToast showToast:@"参数错误"];
            }else if ([dict[@"resultCode"] integerValue] == 2018){
                [MFToast showToast:@"会员不存在"];
            }else if ([dict[@"resultCode"] integerValue] == 9999){
                [MFToast showToast:@"系统异常"];
            }else if ([dict[@"resultCode"] integerValue] == 2015){
                [MFToast showToast:@"未登录，请登录后操作！"];
                [self gotoLoginVc];
            }
        }else{
            [MFToast showToast:dict[@"error"]];
        }
    } failure:^(NSError *error) {
        [MFToast showToast:@"服务器异常"];
    }];
}
- (void)dealResponseDataWithDictionary:(NSDictionary *)dict{
    NSArray * firstArray = dict[@"data"];
    for (NSDictionary * firstDic in firstArray) {
        NSString * key = firstDic[@"imgUrl"];
        NSArray * secondArray = firstDic[@"second"];
        NSString * firstid = firstDic[@"id"];
        NSMutableArray * valuesarr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary * secondDic in secondArray) {
            NSString * title = secondDic[@"bookName"];
            NSString * secondId = secondDic[@"id"];
            OYSampleBookHomeModel * model = [[OYSampleBookHomeModel alloc] init];
            model.firstId = firstid;
            model.secondBookName = title;
            model.secondId = secondId;
            model.firstImageUrl = key;
            [valuesarr addObject:model];
        }
        [self.dataArray addObject:@{key:valuesarr}];
        if (self.dataArray.count <= 3) {
            self.tableView.scrollEnabled = NO;
        }else{
            self.tableView.scrollEnabled = YES;
        }
        [self.tableView reloadData];
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataArray[section] allValues] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OYSampleBookHomeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"OYSampleBookHomeCell" forIndexPath:indexPath];
    //cell被选中时为无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * array = [[self.dataArray[indexPath.section] allValues] lastObject];
    NSMutableArray * titleArray = [NSMutableArray arrayWithCapacity:0];
    for (OYSampleBookHomeModel * model in array) {
        [titleArray addObject:model.secondBookName];
    }
    cell.indexPath = indexPath;
    [cell addValueWithArray:titleArray];
    cell.titleArray = titleArray;
    cell.backgroundColor = [UIColor clearColor];
    __block OYSampleBookHomeVC * weakself = self;
    [cell returnValue:^(NSString *title,NSInteger myIndex) {
        OYSampleBookListVC * listVc = [OYSampleBookListVC shareViewController];
        listVc.titleStr = title;
        OYSampleBookHomeModel * model = [[[self.dataArray[indexPath.section] allValues] lastObject] objectAtIndex:myIndex];
        listVc.firstId = model.firstId;
        listVc.secondId = model.secondId;
        [weakself.navigationController pushViewController:listVc animated:YES];
    }];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 140 * Radio_Y;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30 * Radio_Y;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 160 * Radio_Y)];
    view.backgroundColor = [UIColor clearColor];
    UIImageView * iamgeview = [[UIImageView alloc] initWithFrame:CGRectMake(20 * Radio_X, (140 - 38 - 15) * Radio_Y, 165 * Radio_X, 38 * Radio_Y)];
    [view addSubview:iamgeview];
    iamgeview.backgroundColor = [UIColor clearColor];
    NSString * imageName = [[self.dataArray[section] allKeys] lastObject];
    [iamgeview sd_setImageWithURL:[NSURL URLWithString:imageName]];
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
/**
 设置tableview的样式
 */
- (void)setTableViewApperence{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];;
  
    self.tableView.scrollEnabled = YES;
    self.tableView.backgroundColor = [UIColor clearColor];

  
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView)
        
    {
        UITableView *tableview = (UITableView *)scrollView;
        
        CGFloat sectionHeaderHeight = 160 * Radio_Y;
        
        CGFloat sectionFooterHeight = 0;
        
        CGFloat offsetY = tableview.contentOffset.y;
        
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
            
        {
            
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
            
        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
            
        {
            
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
            
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)         {
            
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
            
        }
        
    }
    
}
- (void)leftNavButtonPressed:(UIButton *)button{
    return;
}

@end
