#import "TestHelper.h"

static BOOL afterAllExecuted = NO;

SpecBegin(_PendingSpecTest3)

describe(@"group", ^{
  afterAll(^{ afterAllExecuted = YES; });
  it(@"it", ^{ NSAssert(YES, nil); });
  pending(@"pending");
});

SpecEnd

@interface PendingSpecTest3 : XCTestCase; @end
@implementation PendingSpecTest3

- (void)testPendingSpec {
  XCTestSuiteRun *result = RunSpec(_PendingSpecTest3Spec);
  SPTAssertEqual([result testCaseCount], 2);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
  SPTAssertTrue(afterAllExecuted);
}

@end
