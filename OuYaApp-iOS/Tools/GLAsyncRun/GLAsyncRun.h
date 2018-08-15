//
//  GLAsyncRun.h
//  duanyang
//
//  App 同步异步请求，请使用该全局方法。
//  Created by yang.duan on 2017/6/25.
//  Copyright © 2017年 duanyang. All rights reserved.
//

typedef void (^GLRun)(void);

/**
 *  异步运行，是属于NSQualityOfServiceDefault的串行队列池
 *
 *  @param run 需要运行的代码
 */

void GLAsyncRunDefault(GLRun run);

/**
 *  异步运行，是属于NSQualityOfServiceUserInitiated的串行队列池
 *
 *  @param run 需要运行的代码
 */
void GLAsyncRun(GLRun run);

/**
 *  回到主线程运行
 *
 *  @param run 需要运行的代码
 */
void GLAsyncRunInMain(GLRun run);
