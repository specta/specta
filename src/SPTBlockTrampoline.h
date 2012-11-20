//
//  SPTBlockTrampoline.h
//  Specta
//
//  Created by Josh Abernathy on 10/21/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// Allows a limited type of dynamic block invocation.
//
// Based on RACBlockTrampline from ReactiveCocoa.
@interface SPTBlockTrampoline : NSObject {
	id _block;
}

// Invokes the given block with the given arguments. All of the block's
// argument types must be objects and must not return anything.
//
// At this time, it only supports blocks that take up to 15 arguments. Any more
// is just cray.
//
// block     - The block to invoke. Must accept as many arguments as are given in
//             the arguments array. Cannot be nil.
// arguments - The arguments with which to invoke the block.
+ (void)invokeBlock:(id)block withArguments:(NSArray *)arguments;

@end
