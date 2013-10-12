//
//  TJLStack.h
//  TJLStack
//
//  Created by Terry Lewis II on 10/12/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//
//
// A simple implementation of a Stack data structure using LIFO ordering.
//
//


#import <Foundation/Foundation.h>

@interface TJLStack : NSObject <NSFastEnumeration>

/**
 * Pushes an object onto the top of the stack. This is a O(1) operation.
 * @param object The object to push, which cannot be nil.
 */
- (void)__attribute__((nonnull(1))) push:(id)object;

/**
 * Pops an object off the top of the stack. This is a O(1) operation.
 * @return The object from the top of the stack.
 */
- (id)pop;

/**
 * Returns the object on the top of the stack without removing it from the stack.
 * @return The object from the top of the stack.
 */
- (id)peek;

/**
 * Returns YES if the stack has no objects, returns NO otherwise.
 * @return If the stack is empty or not.
 */
- (BOOL)isEmpty;

/**
 * Converts the stack to an array while preserving the stack. This is a O(n) operation.
 * @return An array represention of the stack.
 */
- (NSArray *)toArray;

/**
 * The number of items in the stack.
 */
@property(readonly, nonatomic) NSUInteger count;
@end
