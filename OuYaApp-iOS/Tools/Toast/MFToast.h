//
//  MFToast.h
//  duanyang
//
//  Created by duanyang on 10/12/15.
//  Copyright © 2017年 duanyang. All rights reserved.
// 提醒框

#import <Foundation/Foundation.h>

typedef enum { ToastPositionTop, ToastPositionCenter, ToastPositionBottom } ToastPosition;

@interface MFToast : NSObject



+ (void)showToast:(NSString *)text;

@end
