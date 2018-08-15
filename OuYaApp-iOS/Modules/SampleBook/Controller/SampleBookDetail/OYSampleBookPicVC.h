//
//  OYSampleBookPicVC.h
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYSampleBookPicVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *lineIMage;
@property (retain,nonatomic)id dataObject;
@property (nonatomic,assign)BOOL isHiddenLine;
+ (OYSampleBookPicVC *)shareViewController;
@end
