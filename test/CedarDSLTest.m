#import "TestHelper.h"

SPEC_BEGIN(_CedarDSLTest)

it(@"it with PENDING", PENDING);

SPEC_END

@interface CedarDSLTest : SenTestCase; @end
@implementation CedarDSLTest

- (void)testSingleExampleGroup {
  SenTestSuiteRun *result = RunSpec(_CedarDSLTestSpec);
  expect([result testCaseCount]).toEqual(1);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
  expect([result pendingTestCaseCount]).toEqual(1);
}

@end
