#import "TestHelper.h"

SpecBegin(_AsyncSpecTimeoutTest)

describe(@"group", ^{
  it(@"example 1", ^{
    waitUntil(^(DoneCallback done) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 200LL * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        assertFalse(NO);
        done();
      });
    });
  });

  it(@"example 2", ^{
    waitUntil(^(DoneCallback done) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 50LL * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        assertFalse(NO);
        done();
      });
    });
  });
});

SpecEnd

@interface AsyncSpecTimeoutTest : XCTestCase; @end
@implementation AsyncSpecTimeoutTest

- (void)testAsyncSpec {
  setAsyncSpecTimeout(0.1);
  XCTestRun *result = RunSpec(_AsyncSpecTimeoutTestSpec);
  assertEqual([result unexpectedExceptionCount], 0);
  assertEqual([result failureCount], 1);
  assertFalse([result hasSucceeded]);
  setAsyncSpecTimeout(10.0);
}

@end
