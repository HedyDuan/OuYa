//
//  OYSampleBookDetailBottomVC.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookDetailBottomVC.h"
#import "WebViewController.h"

@interface OYSampleBookDetailBottomVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftButtonMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightButtonMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeight;
@property (weak, nonatomic) IBOutlet UIView *bookView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookVIewTitleMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numLabelHeight;
@property (weak, nonatomic) IBOutlet UIButton *bottomLabel;

@end

@implementation OYSampleBookDetailBottomVC

@synthesize pageContent,pageController;
+ (OYSampleBookDetailBottomVC *)shareViewController{
    OYSampleBookDetailBottomVC *mainCtrl =
    [UIStoryboard showControllerWithStoryBoardName:@"SampleBook" VCIdentifier:@"OYSampleBookDetailBottomVC"];
    return mainCtrl;
}

- (void)createContentPages{
    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:10];
    dataArray = [NSMutableArray arrayWithArray:self.imageStrArray];
    if (dataArray.count % 2 != 0) {
        [dataArray addObject:@"whitebg"];
    }
    pageContent = [[NSArray alloc]initWithArray:dataArray];
}
- (OYSampleBookPicVC *)viewCintrollerAtIndex:(NSUInteger)index{
    if ([self.pageContent count] == 0 || (index >= [self.pageContent count])) {
        return nil;
    }
    OYSampleBookPicVC * dataViewController = [OYSampleBookPicVC shareViewController];
    if (index % 2 == 0) {
        dataViewController.isHiddenLine = YES;
    }else{
        dataViewController.isHiddenLine = NO;
    }
    dataViewController.dataObject = [self.pageContent objectAtIndex:index];
    
    return dataViewController;
}
- (NSUInteger)indexOfViewController:(OYSampleBookPicVC*)viewController{
    return  [self.pageContent indexOfObject:viewController.dataObject];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(OYSampleBookPicVC *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]) {
//        [MFToast showToast:@"没有更多"];
        return nil;
    }
    return [self viewCintrollerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(OYSampleBookPicVC *)viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index --;
    return [self viewCintrollerAtIndex:index];
}
- (IBAction)linkAction:(id)sender {
    //网页
    WebViewController *webVc = [WebViewController webVCWithUrlStr:self.linkUrl];
    [self.navigationController pushViewController:webVc animated:YES];
}
#pragma mark -- set/get
- (void)setPageController{
    NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageController = [[UIPageViewController alloc]initWithTransitionStyle:(UIPageViewControllerTransitionStylePageCurl) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:options];
    pageController.dataSource = self;
    self.pageController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.bookView.frame), CGRectGetHeight(self.bookView.frame));
    
    OYSampleBookPicVC * initialViewController = [self viewCintrollerAtIndex:0];
    OYSampleBookPicVC * endViewController = [self viewCintrollerAtIndex:1];
    NSArray * viewControllers = [NSArray arrayWithObjects:initialViewController,endViewController,nil];
    [pageController setViewControllers:viewControllers direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
    [self addChildViewController:pageController];
    [self.bookView addSubview:pageController.view];
    [pageController didMoveToParentViewController:self];
}
- (void)setApperence{
    if (kStringIsEmpty(self.linkUrl)) {
        self.bottomLabel.hidden = YES;
    }else{
        self.bottomLabel.hidden = NO;
    }
    self.leftButtonWidth.constant = 23 * Radio_X;
    self.leftButtonHeight.constant = 18 * Radio_Y;
    self.leftButtonTop.constant = 50 * Radio_Y;
    self.leftButtonMargin.constant = 13 * Radio_X;
    self.titleLabelTop.constant = 46 * Radio_Y;
    self.rightButtonMargin.constant = 14 * Radio_X;
    self.titleLabelHeight.constant = 29 * Radio_Y;
    self.bookViewHeight.constant = 425 * Radio_Y;
    self.bookViewWidth.constant = 959 * Radio_X;
    self.bookVIewTitleMargin.constant = 50 * Radio_Y;
    self.bottomLabelHeight.constant = 24 * Radio_Y;
    self.titleLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:24 * Radio_X];
    self.bottomLabel.titleLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:24 * Radio_X];
    self.numLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:21 * Radio_X];
    self.numLabelWidth.constant = 34 * Radio_X;
    self.numLabelHeight.constant = 21 * Radio_Y;
}
#pragma mark -- life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setApperence];
    [self createContentPages];
    [self setPageController];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
