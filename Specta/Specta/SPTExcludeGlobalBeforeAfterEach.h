/*
 * Copyright (c) 2015 Specta Team. All rights reserved.
 */
#import <Foundation/Foundation.h>

// This protocol is used for blacklisting classes for global beforeEach and afterEach blocks.
// If you do not want a class to participate in those just add this protocol to a category and it will be
// excluded.
@protocol SPTExcludeGlobalBeforeAfterEach <NSObject>
@end
