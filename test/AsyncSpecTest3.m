#import "TestHelper.h"

static NSString
  *foo = @"foo"
, *bar = @"bar"
;

SpecBegin(_AsyncSpecTest3)

describe(@"beforeEach", ^{
  beforeEach(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      SPTAssertEqualObjects(foo, @"foo");
      done();
    });
  });

  it(@"example", ^{
    SPTAssertFalse(NO);
  });
});

describe(@"afterEach", ^{
  afterEach(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      SPTAssertEqualObjects(foo, @"foo");
      done();
    });
  });

  it(@"example", ^{
    SPTAssertFalse(NO);
  });
});

describe(@"beforeAll", ^{
  beforeAll(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      SPTAssertEqualObjects(foo, @"foo");
      done();
    });
  });

  it(@"example", ^{
    SPTAssertFalse(NO);
  });
});

describe(@"afterAll", ^{
  beforeAll(^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      SPTAssertEqualObjects(foo, @"foo");
      done();
    });
  });

  it(@"example", ^{
    SPTAssertFalse(NO);
  });
});

SpecEnd

@interface AsyncSpecTest3 : XCTestCase; @end
@implementation AsyncSpecTest3

- (void)testFailingHooks {
  foo = @"not foo";
  bar = @"not bar";
  XCTestRun *result = RunSpec(_AsyncSpecTest3Spec);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 4);
  SPTAssertFalse([result hasSucceeded]);
  foo = @"foo";
  bar = @"bar";
}

@end
