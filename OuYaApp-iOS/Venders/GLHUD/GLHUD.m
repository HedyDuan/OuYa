//
//  GLHUD.m
//  duanyang
//
//  Created by yang.duan on 2017/8/1.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "GLHUD.h"
#import "MFProgressHUD.h"

static MFProgressHUD *HUD;
static NSInteger GLHUDCount;

@implementation GLHUD

+ (void)showHUD {
    [self showHUDWithCloseBtn:NO];
}

+ (void)showHUDWithHProgress {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    HUD = [[MFProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    HUD.labelText = @"正在加载中";
    HUD.detailsLabelText = @"0%";
    HUD.mode = MFProgressHUDModeDeterminateHorizontalBar;
    [HUD show:NO];
}

+ (void)myProgressTask:(float)progress {
    HUD.progress = progress;
    HUD.detailsLabelText = [NSString stringWithFormat:@"%.2f%%", progress * 100];
}

+ (void)showHUDWithText:(NSString *)text {
    [self showHUDWithCloseBtn:NO text:text];
}

+ (void)showHUDWithCloseBtn:(BOOL)isShow {
    [self showHUDWithCloseBtn:isShow text:@"Loading"];
}

+ (void)showHUDWithCloseBtn:(BOOL)isShow text:(NSString *)text {
    if (GLHUDCount == 0) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        HUD = [[MFProgressHUD alloc] initWithView:window];

        HUD.isShowCloseBtn = isShow;
        [window addSubview:HUD];
        HUD.labelText = text;
        [HUD show:YES];
    }

    GLHUDCount++;
}

+ (void)showHUDinViewController:(UIViewController *)viewCtrl {
    [self showHUDinViewController:viewCtrl isShow:NO];
}

+ (void)showHUDinViewController:(UIViewController *)viewCtrl isShow:(BOOL)isShow {
    HUD = [[MFProgressHUD alloc] initWithView:viewCtrl.view];
    HUD.top = SystemTakeHeight;
    HUD.height -= SystemTakeHeight;
    HUD.isShowCloseBtn = isShow;
    [[NSNotificationCenter defaultCenter] removeObserver:HUD];
    [viewCtrl.view addSubview:HUD];
    HUD.labelText = @"Loading ...";
    [HUD show:YES];
}

+ (void)showHUDinView:(UIView *)view {
    HUD = [[MFProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.labelText = @"Loading ...";
    [HUD show:YES];
}

+ (void)hideHUD {
    GLHUDCount--;
    if (GLHUDCount <= 0) {
        GLHUDCount = 0;
        [HUD hide:YES];
        [HUD removeFromSuperview];
        HUD = nil;
    }
}

+ (void)closeHUD {
    GLHUDCount = 1;
    [self hideHUD];
}
@end
