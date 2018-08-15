//
//  OYSampleBookPicVC.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookPicVC.h"

@interface OYSampleBookPicVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BookRightWidth;

@end

@implementation OYSampleBookPicVC
+ (OYSampleBookPicVC *)shareViewController{
    OYSampleBookPicVC *mainCtrl =
    [UIStoryboard showControllerWithStoryBoardName:@"SampleBook" VCIdentifier:@"OYSampleBookPicVC"];
    return mainCtrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenLine?(self.BookRightWidth.constant = 0):(self.BookRightWidth.constant = 15 * Radio_X);

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.dataObject hasPrefix:@"http://"] || [self.dataObject hasPrefix:@"https://"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataObject]];
    }else{
        self.imageView.image = [UIImage imageNamed:self.dataObject];
    }
    self.lineIMage.hidden = self.isHiddenLine;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
