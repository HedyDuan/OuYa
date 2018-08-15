//
//  OYLoginViewController.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/17.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYLoginViewController.h"
//#import "IQKeyboardManager.h"
#import "OYSampleBookHomeVC.h"
#import "AppDelegate.h"


@interface OYLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *usernameLine;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIView *passWordLine;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userTopToLogo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userlogowidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usernameandtextfieldmargin;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usertfheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passtop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginbuttonwidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertlabelheight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userbackviewwidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginbuttontop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alerttop;

@end

@implementation OYLoginViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.logoToTop.constant = 137 * Radio_Y;
    self.logoHeight.constant = 117 * Radio_Y;
    self.userTopToLogo.constant = 91 * Radio_Y;
    self.userlogowidth.constant = 22.5 * Radio_X;
    self.usernameandtextfieldmargin.constant = 37.5 * Radio_X;
    self.usertfheight.constant = 23 * Radio_Y;
    self.passtop.constant = 35 * Radio_Y;
    self.loginbuttonwidth.constant = 310 * Radio_X;
    self.alertlabelheight.constant = 17 * Radio_Y;
    self.userbackviewwidth.constant = 311 * Radio_X;
    self.loginbuttontop.constant = 54 * Radio_Y;
    self.alerttop.constant = 24 * Radio_Y;

    
    [self.userNameTextField setValue:[UIColor colorForHex:0x999999] forKeyPath:@"placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorForHex:0x999999] forKeyPath:@"placeholderLabel.textColor"];
    self.passwordTextField.placeholder = @"请输入密码";
    self.userNameTextField.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15 * Radio_X];
    self.passwordTextField.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15 * Radio_X];
    self.alertLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12 * Radio_X];
    [self.loginButton.titleLabel setFont: [UIFont fontWithName:@"PingFang-SC-Regular" size:15 * Radio_X]];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

+ (OYLoginViewController *)shareViewController {
    OYLoginViewController *mainCtrl =
    [UIStoryboard showControllerWithStoryBoardName:@"Login" VCIdentifier:[OYLoginViewController className]];
    return mainCtrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //读取上次的配置(记住密码、自动登录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    //处理密码
    if (!kStringIsEmpty([defaults objectForKey:AccountKey]) && !kStringIsEmpty([defaults objectForKey:PwdKey])) {
        self.userNameTextField.text = [defaults objectForKey:AccountKey];
        self.passwordTextField.text = [defaults objectForKey:PwdKey];
        [self login]; // 点击了『登录』按钮
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)login{
    if (kStringIsEmpty(self.userNameTextField.text)) {
        //帐号不存在
        [MFToast showToast:@"请输入账号"];
        return;
    }
    if (kStringIsEmpty(self.passwordTextField.text)) {
        //帐号不存在
        [MFToast showToast:@"请输入密码"];
        return;
    }
    
    [GLHUD showHUD];
    [PPNetworkHelper openLog];
    [PPNetworkHelper POST:@"http://120.55.171.114:8088/api/user/login.do" parameters:@{@"username":self.userNameTextField.text,@"password":self.passwordTextField.text} success:^(id responseObject) {
        [GLHUD hideHUD];
        NSLog(@"首页responseObject==========%@",responseObject);
        NSDictionary * dict = responseObject;
        if (responseObject[@"success"]) {
            if ([dict[@"resultCode"] integerValue] == 1000) {
                [self gotoHomevc];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:self.userNameTextField.text forKey:AccountKey];
                [defaults setObject:self.passwordTextField.text forKey:PwdKey];
                [defaults setObject:dict[@"data"][@"sessionId"]  forKey:SessionIdKey];
                [defaults setObject:[NSString stringWithFormat:@"%d",[dict[@"data"][@"userInfo"][@"id"] integerValue]] forKey:UserIdKey];
                [defaults synchronize];
            }else if ([dict[@"resultCode"] integerValue] == 2001){
                [MFToast showToast:@"参数错误"];
            }else if ([dict[@"resultCode"] integerValue] == 2018){
                [MFToast showToast:@"会员不存在"];
            }else if ([dict[@"resultCode"] integerValue] == 9999){
                [MFToast showToast:@"系统异常"];
            }else if ([dict[@"resultCode"] integerValue] == 20001){
                [MFToast showToast:@"账号或者密码错误，请重新输入！"];
            }else if ([dict[@"resultCode"] integerValue] == 2015){
                [MFToast showToast:@"未登录，请登录后操作！"];
            }
        }else{
            [MFToast showToast:dict[@"error"]];
        }
    } failure:^(NSError *error) {
        [MFToast showToast:error.localizedDescription];
    }];

}
    
- (void)gotoHomevc{
    OYSampleBookHomeVC * vc = [OYSampleBookHomeVC shareViewController];
    UINavigationController *rootNavi =
    [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar class]
                                                  toolbarClass:[UIToolbar class]];
    if ([rootNavi respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        rootNavi.automaticallyAdjustsScrollViewInsets = NO;
    }
    [rootNavi pushViewController:vc animated:NO];
    AppDelegate *app = [AppDelegate sharedDelegate]; // 获取当前app单例
    app.window.rootViewController = rootNavi;
    
    [self removeFromParentViewController];
}
- (IBAction)loginAction:(id)sender {
    [self login];
}




@end
