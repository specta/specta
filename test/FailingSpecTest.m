#import "TestHelper.h"

static NSString
  *foo = @"foo"
, *bar = @"bar"
;

SpecBegin(_FailingSpecTest)

describe(@"group", ^{
  it(@"example 1", ^{
    expect(foo).toEqual(@"foo");
  });

  it(@"example 2", ^{
    expect(bar).toEqual(@"bar");
  });
});

SpecEnd

@interface FailingSpecTest : SenTestCase; @end
@implementation FailingSpecTest

- (void)testFailingSpec {
  foo = @"not foo";
  bar = @"not bar";
  SenTestSuiteRun *result = RunSpec(_FailingSpecTestSpec);
  expect([result failureCount]).toEqual(2);
  expect([result hasSucceeded]).toEqual(NO);
  foo = @"foo";
  bar = @"bar";
}

@end
