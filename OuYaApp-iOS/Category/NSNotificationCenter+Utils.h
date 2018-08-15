//
//  NSNotificationCenter+FR.h
//  duanyang
//
//  Created by duanyang on 2017/6/25.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNotificationCenter (Utils)

+ (void)registerNotificationWithObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)anyObject;

+ (void)registerNotificationWithObserver:(id)observer selector:(SEL)selector name:(NSString *)name;

+ (void)postNotificationName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;

+ (void)postNotificationName:(NSString *)notificationName object:(id)object;

+ (void)removeObserver:(id)observer name:(NSString *)name;

@end
