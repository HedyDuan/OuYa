//
//  UIColor+Utils.m
//  duanyang
//
//  Created by yang.duan on 2017/6/25.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString =
        [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    // R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorForHex:(long)hexColor {
    return [UIColor colorForHex:hexColor Alpha:1.0f];
}

+ (UIColor *)colorForHex:(long)hexColor Alpha:(CGFloat)alpha {
    float r = ((float) ((hexColor & 0xFF0000) >> 16)) / 255.0;
    float g = ((float) ((hexColor & 0xFF00) >> 8)) / 255.0;
    float b = ((float) (hexColor & 0xFF)) / 255.0;

    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (UIColor *)colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    return [UIColor colorWithRed:red green:green blue:blue Alpha:1.f];
}

+ (UIColor *)colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue Alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(float) (red / 255.f)
                           green:(float) (green / 255.f)
                            blue:(float) (blue / 255.f)
                           alpha:alpha];
}

#pragma mark - 具体业务

+ (UIColor *)tabBarSelectTextColor {
    return [UIColor colorForHex:0x58B2DC];
}

+ (UIColor *)tabBarUnSelectTextColor {
    return [UIColor colorForHex:0x999999];
}

+ (UIColor *)tabBarSelectLayerColor {
    return [UIColor clearColor];
}

+ (UIColor *)placeholderColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)navColor {
    return [UIColor whiteColor];
}

@end
