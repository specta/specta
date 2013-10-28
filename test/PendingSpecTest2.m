#import "TestHelper.h"

SpecBegin(_PendingSpecTest2)

describe(@"group", ^{
  xdescribe(@"xdescribe without block");
  xdescribe(@"xdescribe with block", ^{ NSAssert(NO, @"fail"); });

  xcontext(@"xcontext without block");
  xcontext(@"xcontext with block", ^{ NSAssert(NO, @"fail"); });

  xit(@"xit without block");
  xit(@"xit with block", ^{ NSAssert(NO, @"fail"); });

  xspecify(@"xspecify without block");
  xspecify(@"xspecify with block", ^{ NSAssert(NO, @"fail"); });

  xexample(@"xexample without block");
  xexample(@"xexample with block", ^{ NSAssert(NO, @"fail"); });

  pending(@"pending without block");
  pending(@"pending with block", ^{ NSAssert(NO, @"fail"); });
});
SpecEnd

@interface PendingSpecTest2 : XCTestCase; @end
@implementation PendingSpecTest2

- (void)testPendingSpec {
  XCTestSuiteRun *result = RunSpec(_PendingSpecTest2Spec);
  SPTAssertEqual([result testCaseCount], 12);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
  // SPTAssertEqual([result pendingTestCaseCount], 12);
}

@end
