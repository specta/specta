
// XCTestObserver allows us to use multiple observers at the same time
// by setting the XCTestObserverClass user default (See XCTestObserver.h).
// So we need to ensure that the method swizzling by Specta won't crash
// another observer.

@interface MultipleTestObserverTest : XCTestCase
@end

@implementation MultipleTestObserverTest

- (void)testAnotherObserverWorksWithoutCrash {
    XCTestObserver *observer = [[XCTestObserver alloc] init];
    [observer startObserving];
    [observer stopObserving];
}

@end
