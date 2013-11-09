#import "TestHelper.h"

SpecBegin(_PassingSpecTest)

describe(@"group", ^{
  it(@"example 1", ^{
    SPTAssertEqualObjects(@"foo", ([NSString stringWithFormat:@"f%@", @"oo"]));
  });

  it(@"example 2", ^{
    SPTAssertEqual(123, 100 + 23);
  });
});

SpecEnd

@interface PassingSpecTest : XCTestCase; @end
@implementation PassingSpecTest

- (void)testPassingSpec {
  XCTestRun *result = RunSpec(_PassingSpecTestSpec);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
}

@end
