//
//  UIImage+Tint.h
//  EpointFrame5
//
//  Created by Pill.Gong on 14-2-28.
//  Copyright (c) Pill.Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage(Addtions)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
+ (UIImage *) imageWithView:(UIView *)orgView;

- (UIImage *)grayImage;
+ (UIImage *)grayImage:(UIImage *)sourceImage;

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage *)image;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

- (UIImage *)convertToGrayscale;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

// group icon
+ (UIImage *)groupIconWith:(NSArray *)array;
+ (UIImage *)groupIconWith:(NSArray *)array bgColor:(UIColor *)bgColor;

- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

+ (UIImage *)imageWithFileType:(NSString *)fileType;

- (NSData *)dataSmallerThan:(NSUInteger)dataLength;
- (NSData *)dataForCodingUpload;

@end
