//
//  UIView+Additon.h
//  DoubanAlbum
//  方便操作view的工具类
//  Created by Tonny on 12-12-10.
//  Copyright (c) 2012年 SlowsLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additon)

//  将图片的左边移动到指定位置
@property (nonatomic) CGFloat left;


//  将图片的顶端移动到指定位置
@property (nonatomic) CGFloat top;


//  将图片的右边移动到指定位置
@property (nonatomic) CGFloat right;


//  将图片的底端移动到指定位置
@property (nonatomic) CGFloat bottom;


//  更改图片的宽度
@property (nonatomic) CGFloat width;


//  更改图片的高度
@property (nonatomic) CGFloat height;


//  更改图片的位置
@property (nonatomic) CGPoint origin;


//  更改图片的尺寸
@property (nonatomic) CGSize size;

//  更改图片中心点的位置x
@property (nonatomic) CGFloat centerX;

//  更改图片中心点的位置x
@property (nonatomic) CGFloat centerY;

// 返回subview中指定tag的view
- (id)subviewWithTag:(NSInteger)tag;

// 返回view的vc
- (UIViewController*)viewController;

// 返回view的cell
- (UITableViewCell*)tableViewCell;

//水平分隔线
+ (UIView *)separateHorizontalLine:(CGFloat)startY;
+ (UIView *)separateHorizontalLine:(CGFloat)startX :(CGFloat)startY;

//垂直分隔线
+ (UIView *)separateVerticalLine:(CGFloat)startX
                          startY:(CGFloat)startY
                          height:(CGFloat)height;
@end
