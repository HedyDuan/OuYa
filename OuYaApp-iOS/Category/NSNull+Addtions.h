//
//  NSNull+Addtions.h
//  duanyang
//
//  Created by duanyang on 12/1/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (MFAddtions)

- (id)objectForKeyedSubscript:(id)key;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (id)valueForKey:(NSString *)key;

- (id)valueForKeyPath:(NSString *)keyPath;

- (id)objectForKey:(id)key;

- (BOOL)isEqualToString:(NSString *)aString;

- (NSInteger)count;

- (NSInteger)length;

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained[])buffer
                                    count:(NSUInteger)len;
@end
