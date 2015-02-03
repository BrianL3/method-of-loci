//
//  QueueAndStack.m
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/2/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataStructures : NSObject
    @property (strong, nonatomic) NSMutableArray *myStack;
    @property (strong, nonatomic) NSMutableArray *myQueue;

@end

@implementation DataStructures


//initializer
-(instancetype) init {
    if (self = [super init]){
        _myStack = [NSMutableArray arrayWithObjects:@"Fourth",@"Third", @"Second", @"First", nil];
        _myQueue = [NSMutableArray arrayWithObjects:@"First", @"Second", @"Third",@"Fourth", nil];
        
        [self displayQueue];
        [self enqueue:@"fifth"];
        [self peekQueue];
        [self dequeue];
        
        [self displayStack];
        [self push:@"derf"];
        [self peekStack];
        [self displayStack];
    }
    return self;
}
//MARK: QUEUE METHODS ===============================================================
// enqueue adds to the back of the array
-(void)enqueue:(NSString*)aString {
    [_myQueue addObject:aString];
}
//dequeue removes from the front of the array
-(NSString*)dequeue{
    NSString* returnString = [_myQueue firstObject];
    [_myQueue removeObjectAtIndex:0];
    return returnString;
}

//MARK: STACK METHODS ===============================================================
// push adds to the back of the array
-(void)push:(NSString*)aString{
    [_myStack addObject:aString];
}
// pop removes from the back of the array
-(NSString*)pop{
    NSString* returnString = [_myStack lastObject];
    [_myStack removeLastObject];
    return returnString;
}
//MARK: PEEKS ===================================================================
//peek the queue
-(NSString*)peekQueue{
    NSString* returnString = [_myQueue firstObject];
    return returnString;
}

//peek the stack
-(NSString*)peekStack{
    NSString* returnString = [_myStack lastObject];
    return returnString;
}

//MARK: DISPLAY ALL ===============================================================
//display the queue
-(void)displayQueue{
    for (NSString *item in _myQueue) {
        NSLog(@"%@", item);
    }
}
//display the stack
-(void)displayStack{
    for (NSString *item in _myStack) {
        NSLog(@"%@", item);
    }
}

@end;