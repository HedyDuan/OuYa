//
//  MFNavigationController.m
//  duanyang
//
//  Created by duanyang on 10/28/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "MFNavigationController.h"


@interface MFNavigationController ()

@end

@implementation MFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavBar];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateNavBar {
    self.navigationBar.translucent = NO;
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationBar.barTintColor = [UIColor colorForHex:0x333333];
    [self.navigationBar
        setBackgroundImage:[UIImage imageWithColor:[UIColor navColor] size:CGSizeMake(1, 1) cornerRadius:0]
             forBarMetrics:UIBarMetricsDefault];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor navColor]] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont fontWithName:@"SourceHanSansCN-Normal" size:kNavTitleFontSize],
                                     NSForegroundColorAttributeName: [UIColor colorForHex:0x333333],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
    [[UITextField appearance] setTintColor:[UIColor redColor]];//设置UITextField的光标颜色
    [[UITextView appearance] setTintColor:[UIColor redColor]];//设置UITextView的光标颜色
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}

// 支持横竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    if (_supportLandscape) {
//        return UIInterfaceOrientationMaskAll;
//    } else {
//        return UIInterfaceOrientationMaskPortrait;
//    }
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
