#import "TestHelper.h"

static NSString
  *foo = @"foo"
, *bar = @"bar"
;

SpecBegin(_AsyncSpecTest)

describe(@"group", ^{
  it_(@"example 1", ^(void (^done)()) {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(foo).toEqual(@"foo");
      done();
    });
  });

  it_(@"example 2", ^(void (^done)()) {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(bar).toEqual(@"bar");
      done();
    });
  });

  it_(@"example 3", ^(void (^done)()) {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(NO).toBeFalsy();
      done();
    });
  });
});

SpecEnd

@interface AsyncSpecTest : SenTestCase; @end
@implementation AsyncSpecTest

- (void)testAsyncSpec {
  foo = @"not foo";
  bar = @"not bar";
  SenTestRun *result = RunSpec(_AsyncSpecTestSpec);
  expect([result failureCount]).toEqual(2);
  expect([result hasSucceeded]).toEqual(NO);
  foo = @"foo";
  bar = @"bar";
}

@end
