#import "TestHelper.h"

SPEC_BEGIN(_CedarDSLTest)

it(@"it with PENDING", PENDING);

SPEC_END

@interface CedarDSLTest : XCTestCase; @end
@implementation CedarDSLTest

- (void)testSingleExampleGroup {
  XCTestSuiteRun *result = RunSpec(_CedarDSLTestSpec);
  SPTAssertEqual([result testCaseCount], 1);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
  // SPTAssertEqual([result pendingTestCaseCount], 1);
}

@end
