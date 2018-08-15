//
//  OYSampleBookDetailTopVC.h
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYSampleBookDetailTopVC : UIViewController
+ (OYSampleBookDetailTopVC *)shareViewController;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (nonatomic, copy)NSString * imagestr;
@end
