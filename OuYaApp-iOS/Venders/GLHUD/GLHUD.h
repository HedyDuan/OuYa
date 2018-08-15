//
//  GLHUD.h
//  duanyang
//
//  Created by yang.duan on 2017/8/1.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLHUD : NSObject

+ (void)showHUD;

+ (void)showHUDWithHProgress;

+ (void)myProgressTask:(float)progress;

+ (void)showHUDWithText:(NSString *)text;

+ (void)showHUDWithCloseBtn:(BOOL)isShow;

+ (void)showHUDinView:(UIView *)view;

+ (void)showHUDinViewController:(UIViewController *)viewCtrl;

+ (void)showHUDinViewController:(UIViewController *)viewCtrl isShow:(BOOL)isShow;

+ (void)hideHUD;

+ (void)closeHUD;

@end
