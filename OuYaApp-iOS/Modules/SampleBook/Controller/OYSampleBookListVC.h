//
//  OYSampleBookListVC.h
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/17.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "EOPBaseViewController.h"

@interface OYSampleBookListVC : EOPBaseViewController
+ (OYSampleBookListVC *)shareViewController;
@property (nonatomic, copy)NSString * titleStr;
@property (nonatomic, copy)NSString * firstId;
@property (nonatomic, copy)NSString * secondId;
@end
