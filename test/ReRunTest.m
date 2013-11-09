#import "TestHelper.h"

static int
  beforeAllRan
, beforeEachRan
, example1Ran
, example2Ran
, afterEachRan
, afterAllRan
;

SpecBegin(_ReRunTest)

describe(@"group", ^{
  beforeAll(^{
    beforeAllRan ++;
  });

  beforeEach(^{
    beforeEachRan ++;
  });

  it(@"example 1", ^{
    example1Ran ++;
  });

  it(@"example 2", ^{
    example2Ran ++;
  });

  afterEach(^{
    afterEachRan ++;
  });

  afterAll(^{
    afterAllRan ++;
  });
});

SpecEnd

@interface ReRunTest : XCTestCase; @end
@implementation ReRunTest

- (void)test_Tests_should_be_able_to_run_multiple_times {
  beforeEachRan = afterEachRan = example1Ran = example2Ran = beforeAllRan = afterAllRan = 0;

  RunSpec(_ReRunTestSpec);

  SPTAssertEqual(example1Ran, 1);
  SPTAssertEqual(example2Ran, 1);

  SPTAssertEqual(beforeAllRan, 1);
  SPTAssertEqual(beforeEachRan, 2);
  SPTAssertEqual(afterEachRan, 2);
  SPTAssertEqual(afterAllRan, 1);

  RunSpec(_ReRunTestSpec);

  SPTAssertEqual(example1Ran, 2);
  SPTAssertEqual(example2Ran, 2);

  SPTAssertEqual(beforeAllRan, 2);
  SPTAssertEqual(beforeEachRan, 4);
  SPTAssertEqual(afterEachRan, 4);
  SPTAssertEqual(afterAllRan, 2);
}

@end
