#import "TestHelper.h"

SpecBegin(_PassingSpecTest)

describe(@"group", ^{
  it(@"example 1", ^{
    expect(@"foo").toEqual(@"foo");
  });

  it(@"example 2", ^{
    expect(123).toEqual(123);
  });
});

SpecEnd

@interface PassingSpecTest : SenTestCase; @end
@implementation PassingSpecTest

- (void)testPassingSpec {
  SenTestRun *result = RunSpec(_PassingSpecTestSpec);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
}

@end
