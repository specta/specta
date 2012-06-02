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

@interface PendingSpecTest1 : SenTestCase; @end
@implementation PendingSpecTest1

- (void)testPendingSpec {
  SenTestSuiteRun *result = RunSpec(_PendingSpecTest1Spec);
  expect([result testCaseCount]).toEqual(5);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
}

@end
