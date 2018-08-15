//
//  OYSampleDetailVC.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleDetailVC.h"
#import "OYSampleBookDetailTopVC.h"
#import "OYSampleBookDetailMiddleVC.h"
#import "OYSampleBookDetailBottomVC.h"

@interface OYSampleDetailVC ()<UIScrollViewDelegate>
/**内容视图*/
@property (nonatomic,strong)UIScrollView * contentScrollow;
@end

@implementation OYSampleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getData];
    self.titleText = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavButtonWithDefaultIcon];
    [self customScrollview];
    
    //添加子控制器
    [self addChildCustomViewController];
    
    // 默认点击下标为0的标题按钮
    [self titleBtnClick:0];
    
}
//网络请求
- (void)getData{
    [GLHUD showHUD];
    NSDictionary * dict = @{@"sessionId":UserDefault_SeeionidKey,@"userId":UserDefault_UserIdKey,@"bookId":self.model.bookId};
    [PPNetworkHelper POST:@"http://120.55.171.114:8088/api/user/getSampleBookDetail.do" parameters:dict success:^(id responseObject) {
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
        // 结束刷新
    }];
}
- (void)dealResponseDataWithDictionary:(NSDictionary *)dict{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)customScrollview{
    UIScrollView * contentScrollow = [[UIScrollView alloc]init];
    self.contentScrollow = contentScrollow;
    contentScrollow.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    [self.view addSubview:contentScrollow];
    contentScrollow.delegate = self;
    contentScrollow.pagingEnabled = YES;
    contentScrollow.bounces = NO;
    contentScrollow.showsHorizontalScrollIndicator = NO;
}


- (void)addChildCustomViewController{
    //第一个
    OYSampleBookDetailTopVC * fristVc = [OYSampleBookDetailTopVC shareViewController];
    fristVc.imagestr = self.model.detailTopImageStr;
    [self addChildViewController:fristVc];
    
//    //第二个
//    OYSampleBookDetailMiddleVC * secondVc = [OYSampleBookDetailMiddleVC shareViewController];
//    [self addChildViewController:secondVc];
    
    OYSampleBookDetailBottomVC * thirdvc = [OYSampleBookDetailBottomVC shareViewController];
    thirdvc.imageStrArray = self.model.bookArray;
    thirdvc.linkUrl = self.model.linkUrl;
    thirdvc.linkType = self.model.linkType;
    [self addChildViewController:thirdvc];
    
    NSInteger count = self.childViewControllers.count;
    self.contentScrollow.contentSize = CGSizeMake(0, count * UIScreenHeight);
}

- (void)titleBtnClick:(NSInteger)tag{
    self.contentScrollow.contentOffset = CGPointMake(0, tag * UIScreenHeight);
    // 添加子控制器的view
    UIViewController *vc = self.childViewControllers[tag];
    // 如果子控制器的view已经添加过了，就不需要再添加了
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(0, tag * UIScreenHeight, UIScreenWidth, UIScreenHeight - 64);
    [self.contentScrollow addSubview:vc.view];
}


#pragma mark -- uscrollviewDelegate
//开始拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    // 计算拖拽的比例
    //    CGFloat ratio = scrollView.contentOffset.y / scrollView.yj_height;
    //    // 将整数部分减掉，保留小数部分的比例(控制器比例的范围0~1.0)
    //    ratio = ratio - self.preBtn.tag;
    //    NSInteger index = scrollView.contentOffset.y / scrollView.yj_height;
    //    if (isClick) {
    //        UIButton * titleBtn = self.titleBtns[index];
    //
    //        isClick = YES;
    //    }else{
    //        }
}

//开始减速的时候调用
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}


//结束拖动的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.y / scrollView.height;
    // 调用标题按钮的点击事件
    [self titleBtnClick:index];
}
@end
