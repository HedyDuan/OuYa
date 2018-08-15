//
//  NSNull+Addtions.m
//  duanyang
//
//  Created by duanyang on 12/1/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "NSNull+Addtions.h"

@implementation NSNull (MFAddtions)

- (id)objectForKeyedSubscript:(id)key {
    return nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return nil;
}

- (id)valueForKey:(NSString *)key {
    return nil;
}

- (id)valueForKeyPath:(NSString *)keyPath {
    return nil;
}

- (id)objectForKey:(id)key {
    return nil;
}

- (BOOL)isEqualToString:(NSString *)aString {
    return NO;
}

- (NSInteger)count {
    return 0;
}

- (NSInteger)length {
    return 0;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained[])buffer
                                    count:(NSUInteger)len {
    return 0;
}

@end
