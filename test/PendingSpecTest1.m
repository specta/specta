#import "TestHelper.h"

SpecBegin(_PendingSpecTest1)

describe(@"group", ^{
  beforeAll(nil);
  afterAll(nil);
  beforeEach(nil);
  afterEach(nil);

  describe(@"describe with nil", nil);
  context(@"context with nil", nil);

  it(@"it with nil", nil);
  specify(@"specify with nil", nil);
  example(@"example with nil", nil);
});
SpecEnd

@interface PendingSpecTest1 : XCTestCase; @end
@implementation PendingSpecTest1

- (void)testPendingSpec {
  XCTestSuiteRun *result = RunSpec(_PendingSpecTest1Spec);
  SPTAssertEqual([result testCaseCount], 5);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
  // SPTAssertEqual([result pendingTestCaseCount], 5);
}

@end
