//
//  MFBaseViewController.m
//  duanyang
//
//  Created by duanyang on 10/12/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "MFBaseViewController.h"
#import "MFBaseChildView.h"

#import "UIImage+Addtions.h"
#import "WRNavigationBar.h"
#import "OYLoginViewController.h"
#import "AppDelegate.h"

@interface MFBaseViewController ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MFBaseViewController

- (void)dealloc {
    if (_mfChildView) {
        [_mfChildView customDealloc];
    }

    NSLog(@">>>>> %@ VC 销毁了 >>>>>", NSStringFromClass(self.class));
}

+ (MFBaseViewController *)shareViewController {
    return nil;
}

- (NSString *)className {
    return NSStringFromClass([self class]);
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (void)setLeftNavButtonIconName:(NSString *)iconName {
    if (iconName.length > 0) {
        UIButton *button = [self setLeftNavButton];
        [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
}

- (void)setLeftNavButtonText:(NSString *)text {
    if (text.length > 0) {
        UIButton *button = [self setLeftNavButton];
        [button setTitle:text forState:UIControlStateNormal];
        if (UIStatusBarStyleDefault == [UIApplication sharedApplication].statusBarStyle) {
            [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        }
    }
}

- (void)setLeftNavButtonIconNameWithText:(NSString *)text{

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame= CGRectMake(0, 0, 55, 44);
    [backBtn setImage:[UIImage imageNamed:@"navBack"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navBack"] forState:UIControlStateHighlighted];
    [backBtn setTitle:text forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor colorForHex:0x7d7d7d]];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backBtn addTarget:self action:@selector(leftNavButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backIetm = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backIetm;
}


- (UIButton *)setLeftNavBtnText:(NSString *)text {
    if (text.length > 0) {
        UIButton *button = [self setLeftNavButton];
        [button setTitle:text forState:UIControlStateNormal];
        if (UIStatusBarStyleDefault == [UIApplication sharedApplication].statusBarStyle) {
            [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        }
        return button;
    }
    return nil;
}

- (UIButton *)setLeftNavButton {
    if (self.navigationController) {
        self.leftButton = [self leftCustomNavButton];
        [_leftButton addTarget:self
                        action:@selector(leftNavButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
        UIBarButtonItem *negativeSpacer =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        /**
         *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
         *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
         */
        negativeSpacer.width = -45;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
            _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//            [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5 * UIScreenWidth / 375.0, 0, 0)];
            UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
            self.navigationItem.leftBarButtonItem = leftBarButton;
        } else {
            [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            UIBarButtonItem *newItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, newItem, nil];
        }
    }
    return _leftButton;
}

- (void)leftNavButtonPressed:(UIButton *)button {
}

- (UIButton *)customNavButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    UIColor *tintColor = [UIColor darkTextColor];
    if (tintColor) {
        button.tintColor = tintColor;
    }
    return button;
}

- (UIButton *)leftCustomNavButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
        button.frame = CGRectMake(0, 0, 78, 44);
    } else {
        button.frame = CGRectMake(0, 0, 104, 44);
    }
    UIColor *tintColor = [UIColor colorForHex:0xFFFFFF];
    if (tintColor) {
        button.tintColor = tintColor;
    }
    return button;
}
- (UIButton *)setRightNavButtonIconName:(NSString *)iconName {
    UIButton *button = nil;
    if (iconName.length > 0) {
        button = [self setRightNavButton];
        [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }

    return button;
}

- (UIButton *)setRightNavButtonText:(NSString *)text {
    UIButton *button = nil;
    if (text.length > 0) {
        button = [self setRightNavButton];
        [button setTitle:text forState:UIControlStateNormal];
        [button sizeToFit];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        if (UIStatusBarStyleDefault == [UIApplication sharedApplication].statusBarStyle) {
            [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }

    return button;
}

- (UIButton *)setRightNavButton {
    if (self.navigationController) {
        self.rightButton = [self customNavButton];
        [_rightButton addTarget:self
                         action:@selector(rightNavButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        self.navigationItem.rightBarButtonItem = item;
    }

    return _rightButton;
}

- (void)rightNavButtonPressed:(UIButton *)button {
}

- (void)setLeftButtonHidden:(BOOL)hidden {
    self.leftButton.hidden = hidden;
}

- (void)setRightButtonHidden:(BOOL)hidden {
    self.rightButton.hidden = hidden;
}

- (void)setRightButtonEnable:(BOOL)enable {
    self.rightButton.enabled = enable;
}

#pragma mark - title

- (void)setTitleText:(NSString *)text andTitleColor:(UIColor *)color {
    _titleText = text;
    self.titleLabel.text = _titleText;
    [self.titleLabel sizeToFit];
    _titleColor = color;
    self.titleLabel.textColor = color;
}

- (void)setTitleColor:(UIColor *)color {
    _titleColor = color;
    self.titleLabel.textColor = color;
}

- (void)setTitleText:(NSString *)text {
    _titleText = text;
    self.titleLabel.text = _titleText;
    [self.titleLabel sizeToFit];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:14 * Radio_Y];
        self.navigationItem.titleView = _titleLabel;
    }
    return _titleLabel;
}

#pragma mark - old

- (void)viewDidLoad {
    [super viewDidLoad];

//    if (![PPNetworkHelper isNetwork]) {
//        [MFToast showToast:@"网络连接失败，请检查您的网络设置！"];
//    }
    [self setNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (_mfChildView) {
        [_mfChildView customViewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (_mfChildView) {
        [_mfChildView customViewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (_mfChildView) {
        [_mfChildView customViewWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    if (_mfChildView) {
        [_mfChildView customViewDidDisappear:animated];
    }
}

#pragma mark  default nav

- (void)setNav{

    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:NO];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor navColor]];
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@">>>>> %@ VC 收到内存警告 >>>>>", NSStringFromClass(self.class));
}

#pragma mark - add subview & subCtrl

- (void)addChildView:(MFBaseChildView *)childView onView:(UIView *)superView {
    [self addSubView:childView toSuperView:superView];
    [childView initializationCode];
    self.mfChildView = childView;
}

- (void)addSubView:(UIView *)subView toSuperView:(UIView *)superView {
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:subView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:superView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0f
                                                                        constant:0.0f];
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:subView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:superView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.f
                                                                          constant:0.0f];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:subView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:superView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0f
                                                                      constant:0.0f];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:subView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:superView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f
                                                                         constant:0.0f];
    [superView addSubview:subView];
    [superView addConstraints:@[ widthConstraint, centerXConstraint, topConstraint, bottomConstraint ]];
    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
}
- (void)gotoLoginVc{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:AccountKey];
    [defaults setObject:@"" forKey:PwdKey];
    [defaults setObject:@""  forKey:SessionIdKey];
    [defaults setObject:@"" forKey:UserIdKey];
    [defaults synchronize];
    OYLoginViewController * vc = [OYLoginViewController shareViewController];
    UINavigationController *rootNavi =
    [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar class]
                                                  toolbarClass:[UIToolbar class]];
    if ([rootNavi respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        rootNavi.automaticallyAdjustsScrollViewInsets = NO;
    }
    [rootNavi pushViewController:vc animated:NO];
    AppDelegate *app = [AppDelegate sharedDelegate]; // 获取当前app单例
    app.window.rootViewController = rootNavi;
    [app.window makeKeyAndVisible];
    [self removeFromParentViewController];
}
@end
