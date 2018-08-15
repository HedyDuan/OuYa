//
//  MFToast.m
//  duanyang
//
//  Created by duanyang on 10/12/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "MFToast.h"

static UILabel *toastLable;
static NSTimer *toastTimer;

@implementation MFToast

+ (void)showToast:(NSString *)text position:(ToastPosition)position time:(NSTimeInterval)second {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];

    [self stopLastToast];

    if (toastLable == nil) {
        toastLable = [[UILabel alloc] initWithFrame:CGRectZero];
        toastLable.textColor = [UIColor whiteColor];
        toastLable.textAlignment = NSTextAlignmentCenter;
        toastLable.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
        toastLable.layer.cornerRadius = 5.0;
        toastLable.numberOfLines = 0;
    }

    toastLable.text = text;
    toastLable.frame = CGRectZero;
    [toastLable sizeToFit];

    if (toastLable.width > UIScreenWidth - 30) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentJustified; //设置对齐方式
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        // paragraph.maximumLineHeight = 21;

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:toastLable.font forKey:NSFontAttributeName];
        [dic setObject:NSParagraphStyleAttributeName forKey:paragraph];

        CGSize size = [toastLable.text boundingRectWithSize:CGSizeMake(UIScreenWidth - 30, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:dic
                                                    context:nil]
                          .size;
        toastLable.size = size;
    }

    toastLable.width += 20;
    toastLable.height += 20;

    toastLable.centerX = UIScreenWidth * 0.5;
    switch (position) {
        case ToastPositionTop:
            toastLable.centerY = UIScreenHeight * 0.25;
            break;
        case ToastPositionCenter:
            toastLable.centerY = UIScreenHeight * 0.5;
            break;
        case ToastPositionBottom:
            toastLable.centerY = UIScreenHeight * 0.85;
            break;
        default:
            break;
    }
    toastLable.alpha = 1.0;
    [window addSubview:toastLable];

    toastTimer = [NSTimer scheduledTimerWithTimeInterval:second
                                                  target:self
                                                selector:@selector(hideToast:)
                                                userInfo:nil
                                                 repeats:NO];
}

+ (void)showToast:(NSString *)text position:(ToastPosition)position {
    [self showToast:text position:position time:0.9];
}

+ (void)showToast:(NSString *)text {
    [self showToast:text position:ToastPositionCenter time:0.9];
}

+ (void)hideToast:(NSTimer *)timer {
    [toastTimer invalidate];
    toastTimer = nil;
    [UIView animateWithDuration:0.1
        animations:^{
          toastLable.alpha = 0.0f;
        }
        completion:^(BOOL finished) {
          [toastLable removeFromSuperview];
        }];
}

+ (void)stopLastToast {
    if (toastTimer) {
        [toastTimer invalidate];
        toastTimer = nil;
    }
    if (toastLable) {
        toastLable.alpha = 0.0f;
        [toastLable removeFromSuperview];
    }
}

@end
