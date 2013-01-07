#import "TestHelper.h"

SpecBegin(_AsyncSpecTest)

describe(@"group", ^{
  it_(@"example 1", ^(void (^done)()) {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(YES).toBeFalsy();
      done();
    });
  });
});

SpecEnd

@interface AsyncSpecTest : SenTestCase; @end
@implementation AsyncSpecTest

- (void)testAsyncSpec {
  SenTestRun *result = RunSpec(_AsyncSpecTestSpec);
  expect([result failureCount]).toEqual(1);
  expect([result hasSucceeded]).toEqual(NO);
}

@end
