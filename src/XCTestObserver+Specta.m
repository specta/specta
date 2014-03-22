#import "XCTestObserver+Specta.h"
#import "SPTReporter.h"
#import <objc/runtime.h>

static void spt_swizzleInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
  Method originalMethod = class_getInstanceMethod(class, originalSelector);
  Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

  method_exchangeImplementations(originalMethod, swizzledMethod);
}

@implementation XCTestObserver (Specta)

+ (void)load {
  spt_swizzleInstanceMethod(self, @selector(startObserving), @selector(XCTestObserver_startObserving));
  spt_swizzleInstanceMethod(self, @selector(stopObserving), @selector(XCTestObserver_stopObserving));
}

- (BOOL)spt_shouldProxyToSPTReporter {
  // Instances of XCTestLog (but not subclasses) simply forward to -[SPTReporter sharedReporter]
  return [self isMemberOfClass:[XCTestLog class]];
}

- (void)spt_pauseObservationInBlock:(void (^)(void))block {
  [self XCTestObserver_stopObserving];
  block();
  [self XCTestObserver_startObserving];
}

#pragma mark - XCTestObserver

- (void)XCTestObserver_startObserving {
  if ([self spt_shouldProxyToSPTReporter]) {
    [[SPTReporter sharedReporter] startObserving];
  } else {
    [self XCTestObserver_startObserving];
  }
}

- (void)XCTestObserver_stopObserving {
  if ([self spt_shouldProxyToSPTReporter]) {
    [[SPTReporter sharedReporter] stopObserving];
  } else {
    [self XCTestObserver_stopObserving];
    usleep(100000);
  }
}

@end
