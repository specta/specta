#import "TestHelper.h"

SpecBegin(_AsyncSpecTimeoutTest)

describe(@"group", ^{
  it(@"example 1", ^AsyncBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 200LL * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
      SPTAssertFalse(NO);
      done();
    });
  });

  it(@"example 2", ^AsyncBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 50LL * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
      SPTAssertFalse(NO);
      done();
    });
  });
});

SpecEnd

@interface AsyncSpecTimeoutTest : XCTestCase; @end
@implementation AsyncSpecTimeoutTest

- (void)testAsyncSpec {
  setAsyncSpecTimeout(0.1);
  XCTestRun *result = RunSpec(_AsyncSpecTimeoutTestSpec);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 1);
  SPTAssertFalse([result hasSucceeded]);
  setAsyncSpecTimeout(10.0);
}

@end
