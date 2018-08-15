//
//  EqualSpaceFlowLayout.h
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/16.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  EqualSpaceFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>
@end

@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id<EqualSpaceFlowLayoutDelegate> delegate;
@end  
