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

@interface PendingSpecTest2 : SenTestCase; @end
@implementation PendingSpecTest2

- (void)testPendingSpec {
  SenTestSuiteRun *result = RunSpec(_PendingSpecTest2Spec);
  expect([result testCaseCount]).toEqual(12);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
}

@end
