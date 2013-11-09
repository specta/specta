#import "TestHelper.h"

static int
  beforeEachRan
, example1RanCorrectly
, example2RanCorrectly
, afterEachRan
;

SpecBegin(_CompilationTest4)

describe(@"group", ^{
  beforeEach(^{
    beforeEachRan ++;
  });

  it(@"example 1", ^{
    if (beforeEachRan == 1 && afterEachRan == 0) {
      example1RanCorrectly ++;
    }
  });

  it(@"example 2", ^{
    if (beforeEachRan == 2 && afterEachRan == 1) {
      example2RanCorrectly ++;
    }
  });

  afterEach(^{
    afterEachRan ++;
  });
});

SpecEnd

@interface CompilationTest4 : XCTestCase; @end
@implementation CompilationTest4

- (void)testBeforeEachAndAfterEachHooks {
  beforeEachRan = afterEachRan = example1RanCorrectly = example2RanCorrectly = 0;

  RunSpec(_CompilationTest4Spec);

  SPTAssertEqual(example1RanCorrectly, 1);
  SPTAssertEqual(example2RanCorrectly, 1);

  SPTAssertEqual(beforeEachRan, 2);
  SPTAssertEqual(afterEachRan, 2);
}

@end
