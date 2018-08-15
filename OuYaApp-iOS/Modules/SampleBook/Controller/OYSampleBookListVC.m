//
//  OYSampleBookListVC.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/17.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookListVC.h"
#import "OYSampleBookListCell.h"
#import "OYSampleBookListModel.h"
#import "OYSampleDetailVC.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "MJRefresh.h"

@interface OYSampleBookListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLeft;
/**
 当前页数
 */
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation OYSampleBookListVC
#pragma mark -- privite
+ (OYSampleBookListVC *)shareViewController {
    OYSampleBookListVC *mainCtrl =
    [UIStoryboard showControllerWithStoryBoardName:@"SampleBook" VCIdentifier:[OYSampleBookListVC className]];
    return mainCtrl;
}
- (void)initializationUI{
    [self setCommonUI];
    NSArray * image = @[@"缤纷摩洛哥",@"波尔沃",@"哥本哈根",@"卡萝",@"科莫",@"玛格丽特",@"满庭芳",@"咪兔",@"飘",@"浅浅清欢"];
    for (int i = 0; i < image.count; i ++) {
        OYSampleBookListModel * model = [[OYSampleBookListModel alloc] init];
        model.imageStr = image[i];
        model.titleStr = @"你好";
        [self.dataArray addObject:model];
    }
}
- (void)initializationCode {
    //增加头部和底部刷新控件
    [self addMjrefreshHeaderAndFooter];
}
#pragma mark -- network

/**
 开始下拉刷新
 */
- (void)pullDownRefresh {
    _curPage = 1;
    if (!kArrayIsEmpty(self.dataArray)) {
        [self.dataArray removeAllObjects];
    }
    [self getDataWithIsPullUp:NO];
}
/**
 上拉加载更多邮件
 */
- (void)pullUpRefresh {
    _curPage = _curPage + 1;
    [self getDataWithIsPullUp:YES];
}
//网络请求
- (void)getDataWithIsPullUp:(BOOL)isup{
    [GLHUD showHUD];
    NSDictionary * dict = @{@"sessionId":UserDefault_SeeionidKey,@"userId":UserDefault_UserIdKey,@"firstId":self.firstId,@"secondId":self.secondId,@"currentPage":[NSString stringWithFormat:@"%ld",(long)_curPage],@"limitNum":@"20"};
    [PPNetworkHelper POST:@"http://120.55.171.114:8088/api/user/searchSampleBook.do" parameters:dict success:^(id responseObject) {
        [GLHUD hideHUD];
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
            [MFToast showToast: dict[@"error"]];
        }
        // 结束刷新
        [self endHeaderAndFooterRefreshing];
    } failure:^(NSError *error) {
        [MFToast showToast:error.localizedDescription];
        // 结束刷新
        [self endHeaderAndFooterRefreshing];
    }];
}
- (void)dealResponseDataWithDictionary:(NSDictionary *)dict{
    NSArray * resultarr = dict[@"data"][@"results"];
    for (NSDictionary * resultdict in resultarr) {
        OYSampleBookListModel * model = [[OYSampleBookListModel alloc] init];
        model.imageStr = resultdict[@"coverUrl"];
        model.bookId = [NSString stringWithFormat:@"%@",resultdict[@"id"]];
        model.bookArray = [NSMutableArray arrayWithArray:resultdict[@"detailUrlList"]];
        model.detailTopImageStr = resultdict[@"introductionUrl"];
        model.linkUrl = resultdict[@"linkUrl"];
        model.linkType = resultdict[@"linkType"];
//        model.linkUrl = @"https://www.baidu.com";
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
}


#pragma mark -- UICollectionViewDataSource

// 告诉系统一共多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 告诉系统每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.从缓存池中取
    OYSampleBookListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OYSampleBookListCell" forIndexPath:indexPath];
    [cell addValueWithModel:self.dataArray[indexPath.row]];
 
    return cell;
}

#pragma mark -- UICollectionViewDelegate
//UICollectionView被选中的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zd",indexPath.item);
    OYSampleDetailVC * detailvc = [[OYSampleDetailVC alloc] init];
    detailvc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailvc animated:YES];
}

// 返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark --
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(162 * Radio_X, 186 * Radio_Y);
}

//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0 * Radio_X, 0, 0 * Radio_X);
}

//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 23 * Radio_Y;
}

//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0 * Radio_Y;
}
//设置标题头的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    //水平滑动时：第一个参数有效
    //竖直滑动时：第二个参数有效
    return CGSizeMake(50, 120 * Radio_Y);
}


#pragma mark -- MJRefresh

/**
 增加mjrefresh的头和尾部
 */
- (void)addMjrefreshHeaderAndFooter{
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pullDownRefresh];
    }];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self pullUpRefresh];
    }];
    //自动更改透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self pullDownRefresh];

}


/**
 结束头部刷新/下拉刷新
 */
- (void)endHeaderRefreshing {
    //结束头部刷新
    [self.collectionView.mj_header endRefreshing];
}

/**
 结束尾部刷新/结束上拉加载更多
 */
- (void)endFooterRefreshing {
    //结束尾部刷新
    [self.collectionView.mj_footer endRefreshing];
}

/**
 结束头部和尾部刷新控件显示
 */
- (void)endHeaderAndFooterRefreshing {
    [self endHeaderRefreshing];
    [self endFooterRefreshing];
}

#pragma mark --- set/get
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (void)setCommonUI{
    self.view.backgroundColor = [UIColor colorForHex:0xededed];
    self.bottomHeight.constant = 120 * Radio_Y;
    self.bottomLeft.constant = 343 * Radio_X;
    self.leftMargin.constant = 65 * Radio_X;
    self.topImageTopMargin.constant = 29 * Radio_Y;
    self.topImageWidth.constant = 120 * Radio_X;
    self.collectionViewWidth.constant = 895 * Radio_X;
    self.topImageHeight.constant = 13 * Radio_Y;
    self.collectionView.scrollEnabled = YES;
    self.titleText = self.titleStr;
    [self setLeftNavButtonWithDefaultIcon];
    [self.collectionView registerNib:[UINib nibWithNibName:@"OYSampleBookListCell" bundle:nil] forCellWithReuseIdentifier:@"OYSampleBookListCell"];
}
#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationUI];
    [self initializationCode];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
