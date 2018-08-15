//
//  NSNotificationCenter+FR.m
//  duanyang
//
//  Created by duanyang on 2017/6/25.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "NSNotificationCenter+Utils.h"
#include <pthread.h>


@implementation NSNotificationCenter (Utils)

+ (void)registerNotificationWithObserver:(id)observer
                                selector:(SEL)selector
                                    name:(NSString *)name
                                  object:(id)anyObject {
    [[self defaultCenter] addObserver:observer selector:selector name:name object:anyObject];
}

+ (void)registerNotificationWithObserver:(id)observer selector:(SEL)selector name:(NSString *)name {
    [self registerNotificationWithObserver:observer selector:selector name:name object:nil];
}

+ (void)postNotificationName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo {
    [[self defaultCenter] postNotificationName:notificationName object:nil userInfo:userInfo];
}

+ (void)postNotificationName:(NSString *)notificationName object:(id)object {
    [[self defaultCenter] postNotificationName:notificationName object:object userInfo:nil];
}

+ (void)removeObserver:(id)observer name:(NSString *)name {
    if (name) {
        [[self defaultCenter] removeObserver:observer name:name object:nil];
    } else {
        [[self defaultCenter] removeObserver:observer];
    }
}

- (void)postNotificationOnMainThread:(NSNotification *)notification {
    if (pthread_main_np()) return [self postNotification:notification];
    [self postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(_yy_postNotification:)
                                   withObject:notification
                                waitUntilDone:wait];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:nil];
    [self postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(_yy_postNotificationName:) withObject:info waitUntilDone:wait];
}

+ (void)_yy_postNotification:(NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+ (void)_yy_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];

    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

@end
