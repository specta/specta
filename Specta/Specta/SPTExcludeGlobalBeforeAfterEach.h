/*
 * Copyright (c) 2015 Specta Team. All rights reserved.
 */
#import <Foundation/Foundation.h>

// This protocol was used for blacklisting classes for global beforeEach and afterEach blocks.
// Now, instead, classes are whitelisted by implementing the SPTIncludeGlobalBeforeAfterEach protocol.
__deprecated
@protocol SPTExcludeGlobalBeforeAfterEach <NSObject>
@end
