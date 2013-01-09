#import "TestHelper.h"

static BOOL shouldInvokeItShouldBehaveLike = NO;

SpecBegin(_SharedExamplesTest5)

sharedExamplesFor(@"shared1", ^(NSDictionary *data) {});

describe(@"group", ^{
  it(@"should fail", ^{
    if(shouldInvokeItShouldBehaveLike) {
      itShouldBehaveLike(@"shared1", nil);
    }
  });
});

SpecEnd

@interface SharedExamplesTest5 : SenTestCase; @end
@implementation SharedExamplesTest5

- (void)testSharedExamplesFailingIfCalledInsideAnItBlock {
  shouldInvokeItShouldBehaveLike = YES;
  SenTestSuiteRun *result = RunSpec(_SharedExamplesTest5Spec);
  expect([result testCaseCount]).toEqual(1);
  expect([result failureCount]).toEqual(1);
  expect([result hasSucceeded]).toEqual(NO);
  shouldInvokeItShouldBehaveLike = NO;
}

@end
