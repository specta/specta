#import "TestHelper.h"

static NSString
  *foo = @"foo"
, *bar = @"bar"
;

SpecBegin(_AsyncSpecTest3)

describe(@"beforeEach", ^{
  beforeEach(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(foo).toEqual(@"foo");
      done();
    });
  });

  it(@"example", ^{
    expect(NO).toBeFalsy();
  });
});

describe(@"afterEach", ^{
  afterEach(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(foo).toEqual(@"foo");
      done();
    });
  });

  it(@"example", ^{
    expect(NO).toBeFalsy();
  });
});

describe(@"beforeAll", ^{
  beforeAll(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(foo).toEqual(@"foo");
      done();
    });
  });

  it(@"example", ^{
    expect(NO).toBeFalsy();
  });
});

describe(@"afterAll", ^{
  beforeAll(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      expect(foo).toEqual(@"foo");
      done();
    });
  });

  it(@"example", ^{
    expect(NO).toBeFalsy();
  });
});

SpecEnd

@interface AsyncSpecTest3 : SenTestCase; @end
@implementation AsyncSpecTest3

- (void)testFailingHooks {
  foo = @"not foo";
  bar = @"not bar";
  SenTestRun *result = RunSpec(_AsyncSpecTest3Spec);
  expect([result failureCount]).toEqual(4);
  expect([result hasSucceeded]).toEqual(NO);
  foo = @"foo";
  bar = @"bar";
}

@end
