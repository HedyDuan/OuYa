//
//  EOPBaseViewController.m
//  duanyang
//
//  Created by duanyang on 10/28/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "EOPBaseViewController.h"

#import "AppDelegate.h"

#import "UIImage+Addtions.h"

@interface EOPBaseViewController ()

@end

@implementation EOPBaseViewController

- (void)setTitleText:(NSString *)text {
    [self setTitleText:text andTitleColor:[UIColor colorForHex:0x333333]];
    
}

- (void)setLeftNavButtonWithDefaultIcon {
    [self setLeftNavButtonIconName:@"样册_返回"];
}

- (void)setRightNavButtonWithCloseIcon {
    [self setRightNavButtonIconName:@"navToHome"];
}

- (void)leftNavButtonPressed:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightNavButtonPressed:(UIButton *)button {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
