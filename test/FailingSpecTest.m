#import "TestHelper.h"

static NSString
  *foo = @"foo"
, *bar = @"bar"
;

SpecBegin(_FailingSpecTest)

describe(@"group", ^{
  it(@"example 1", ^{
    SPTAssertEqualObjects(foo, @"foo");
  });

  it(@"example 2", ^{
    SPTAssertEqualObjects(bar, @"bar");
  });
});

SpecEnd

@interface FailingSpecTest : XCTestCase; @end
@implementation FailingSpecTest

- (void)testFailingSpec {
  foo = @"not foo";
  bar = @"not bar";
  XCTestSuiteRun *result = RunSpec(_FailingSpecTestSpec);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 2);
  SPTAssertFalse([result hasSucceeded]);
  foo = @"foo";
  bar = @"bar";
}

@end
