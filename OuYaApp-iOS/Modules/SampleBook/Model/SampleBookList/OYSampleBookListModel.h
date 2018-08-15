//
//  OYSampleBookListModel.h
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/18.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OYSampleBookListModel : NSObject
@property (nonatomic, copy)NSString * imageStr;
@property (nonatomic, copy)NSString * titleStr;
@property (nonatomic, copy)NSString * bookId;
@property (nonatomic, copy)NSString * detailTopImageStr;//详情页面顶部的图片
@property (nonatomic, strong)NSMutableArray * bookArray;
@property (nonatomic, copy)NSString * detailtitleImagestr;
@property (nonatomic, copy)NSString * linkUrl;
@property (nonatomic, copy)NSString * linkType;


@end
