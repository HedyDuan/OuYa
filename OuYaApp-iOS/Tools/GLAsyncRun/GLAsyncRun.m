//
//  GLAsyncRun.m
//  duanyang
//
//  Created by yang.duan on 2017/6/25.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "GLAsyncRun.h"
#import <Foundation/Foundation.h>

void GLAsyncRunDefault(GLRun run) {
 
}

void GLAsyncRun(GLRun run) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      //开辟一个新的线程 用来处理耗时的操作
      run();
    });

}

void GLAsyncRunInMain(GLRun run) {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
      //进入主线程 更新界面
      run();
    });
}
