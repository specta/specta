#import "TestHelper.h"

static NSString
  *foo = @"foo"
, *bar = @"bar"
;

SpecBegin(_AsyncSpecTest)

describe(@"group", ^{
  it(@"example 1", ^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      SPTAssertEqualObjects(foo, @"foo");
      done();
    });
  });

  it(@"example 2", ^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      SPTAssertEqualObjects(bar, @"bar");
      done();
    });
  });

  it(@"example 3", ^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
      SPTAssertFalse(NO);
      done();
    });
  });
});

SpecEnd

@interface AsyncSpecTest : XCTestCase; @end
@implementation AsyncSpecTest

- (void)testAsyncSpec {
  foo = @"not foo";
  bar = @"not bar";
  XCTestRun *result = RunSpec(_AsyncSpecTestSpec);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 2);
  SPTAssertFalse([result hasSucceeded]);
  foo = @"foo";
  bar = @"bar";
}

@end
