//
//  OYSampleBookDetailBottomVC.h
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OYSampleBookPicVC.h"
@interface OYSampleBookDetailBottomVC : UIViewController
<UIPageViewControllerDataSource>{
    UIPageViewController * pageController;
    NSArray * pageContent;
}
@property(strong,nonatomic)UIPageViewController * pageController;
@property(strong,nonatomic)NSArray * pageContent;
@property (nonatomic, strong)NSArray * imageStrArray;//图片名字数组
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (nonatomic, copy)NSString * linkUrl;
@property (nonatomic, copy)NSString * linkType;
+ (OYSampleBookDetailBottomVC *)shareViewController;
@end
