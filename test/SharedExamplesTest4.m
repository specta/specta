#import "TestHelper.h"

SpecBegin(_SharedExamplesTest4)

__block NSString *foo = nil;

beforeEach(^{
  foo = @"bar";
});

itShouldBehaveLike(@"shared example with data supplied from beforeEach", ^{
  return [NSDictionary dictionaryWithObject:foo forKey:@"foo"];
});

SpecEnd

SharedExamplesBegin(_SharedExamplesTest4)

sharedExamples(@"shared example with data supplied from beforeEach", ^(NSDictionary *data) {
  it(@"inserts data.baz to items", ^{
    expect([data objectForKey:@"foo"]).toEqual(@"bar");
  });
});

SharedExamplesEnd

@interface SharedExamplesTest4 : SenTestCase; @end
@implementation SharedExamplesTest4

- (void)testSharedExamples {
  SenTestSuiteRun *result = RunSpec(_SharedExamplesTest4Spec);
  expect([result testCaseCount]).toEqual(1);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
}

@end
