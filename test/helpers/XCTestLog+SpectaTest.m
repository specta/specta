#import "XCTestLog+SpectaTest.h"
#import <objc/runtime.h>

static XCTestLog *testLog = nil;

@implementation XCTestLog (SpectaTest)

+ (void)load {
  Method startObserving = class_getInstanceMethod(self, @selector(startObserving));
  Method startObserving_swizzle = class_getInstanceMethod(self, @selector(startObserving_swizzle));
  method_exchangeImplementations(startObserving, startObserving_swizzle);
}

+ (XCTestLog *)spt_sharedTestLog {
  return testLog;
}

- (void)startObserving_swizzle {
  testLog = self;
  [self startObserving_swizzle]; // call original
}

@end