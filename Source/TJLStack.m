//
//  TJLStack.m
//  TJLStack
//
//  Created by Terry Lewis II on 10/12/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TJLStack.h"

@interface TJLNode : NSObject
@property(strong, nonatomic) TJLNode *next;
@property(strong, nonatomic) id data;
@end

@implementation TJLNode
@end

@interface TJLStack ()
@property(strong, nonatomic) TJLNode *head;
@property(nonatomic) NSUInteger size;
@property(nonatomic) unsigned long mutations;
@end

@implementation TJLStack
- (instancetype)init {
    self = [super init];
    if(!self) {
        return nil;
    }
    _mutations = 0;
    _size = 0;
    _head = nil;

    return self;
}

- (void)push:(id)object {
    NSAssert((object), @"Object cannot be nil.");
    if(!self.head) {
        TJLNode *nextNode = [TJLNode new];
        nextNode.data = object;
        self.head = nextNode;
    }
    else {
        TJLNode *nextNode = [TJLNode new];
        nextNode.data = object;
        nextNode.next = self.head;
        self.head = nextNode;
    }
    self.size++;
    self.mutations++;
}

- (id)pop {
    if(!self.isEmpty) {
        id object = self.head.data;
        self.head = self.head.next;
        self.size--;
        self.mutations--;
        return object;
    }
    else {
        return nil;
    }
}

- (id)peek {
    return self.head.data;
}

- (NSArray *)toArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for(id object in self) {
        [array addObject:object];
    }
    return array;
}

- (void)enumerateUsingBlock:(void (^)(id object, BOOL *stop))block {
    [self enumerate:[block copy]];
}

- (void)enumerateAsynchronouslyUsingBlock:(void (^)(id object, BOOL *stop))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
        [self enumerateUsingBlock:[block copy]];
    });
}

- (void)enumerate:(void (^)(id object, BOOL *stop))block {
    BOOL stop = NO;
    for(id object in self) {
        if(stop) break;
        if(block) block(object, &stop);
    }
}

- (NSUInteger)count {
    return self.size;
}

- (BOOL)isEmpty {
    return self.head == nil;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
    if(state->state == 0) { // first time
        state->state = 1; // Must set to non-zero
        state->mutationsPtr = &_mutations;  // Can't be NULL.
        state->extra[0] = (unsigned long)_head;
    }
    TJLNode *scan = (__bridge TJLNode *)((void *)state->extra[0]);

    NSUInteger i;
    for(i = 0; i < len && scan != nil; i++) {
        buffer[i] = scan.data;
        scan = scan.next;
    }
    state->extra[0] = (unsigned long)scan;

    state->itemsPtr = buffer;

    return i;
}

@end

