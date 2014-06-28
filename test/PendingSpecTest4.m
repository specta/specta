#import "TestHelper.h"
#import "XCTestRun+Specta.h"

static BOOL beforeAllExecuted, beforeEachExecuted, afterEachExecuted, afterAllExecuted;

SpecBegin(_PendingSpecTest4)

describe(@"group", ^{
  beforeAll(^{ beforeAllExecuted = YES; });
  beforeEach(^{ beforeEachExecuted = YES; });
  afterEach(^{ afterEachExecuted = YES; });
  afterAll(^{ afterAllExecuted = YES; });
  pending(@"pending");
});

SpecEnd

@interface PendingSpecTest4 : XCTestCase; @end
@implementation PendingSpecTest4

- (void)testPendingSpec {
  XCTestSuiteRun *result = RunSpec(_PendingSpecTest4Spec);
  SPTAssertEqual([result testCaseCount], 1);
  SPTAssertEqual([result spt_pendingTestCaseCount], 1);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
  SPTAssertTrue(beforeAllExecuted);
  SPTAssertFalse(beforeEachExecuted);
  SPTAssertFalse(afterEachExecuted);
  SPTAssertTrue(afterAllExecuted);
}

@end
