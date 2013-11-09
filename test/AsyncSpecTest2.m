#import "TestHelper.h"

static int
  beforeAllRan
, beforeEachRan
, example1RanCorrectly
, example2RanCorrectly
, afterEachRan
, afterAllRan
;

SpecBegin(_AsyncSpecTest2)

describe(@"group", ^{
  beforeAll(^AsyncBlock {
    beforeAllRan ++;
    done();
  });

  beforeEach(^AsyncBlock {
    beforeEachRan ++;
    done();
  });

  it(@"example 1", ^{
    if (beforeAllRan == 1 && beforeEachRan == 1 &&
       afterEachRan == 0 && afterAllRan == 0) {
      example1RanCorrectly ++;
    }
  });

  it(@"example 2", ^{
    if (beforeAllRan == 1 && beforeEachRan == 2 &&
       afterEachRan == 1 && afterAllRan == 0) {
      example2RanCorrectly ++;
    }
  });

  afterEach(^AsyncBlock {
    afterEachRan ++;
    done();
  });

  afterAll(^AsyncBlock {
    afterAllRan ++;
    done();
  });
});

SpecEnd

@interface AsyncSpecTest2 : XCTestCase; @end
@implementation AsyncSpecTest2

- (void)testBeforeAllAndAfterAllHooks {
  beforeEachRan = afterEachRan = example1RanCorrectly = example2RanCorrectly = beforeAllRan = afterAllRan = 0;

  RunSpec(_AsyncSpecTest2Spec);

  SPTAssertEqual(example1RanCorrectly, 1);
  SPTAssertEqual(example2RanCorrectly, 1);

  SPTAssertEqual(beforeAllRan, 1);
  SPTAssertEqual(beforeEachRan, 2);
  SPTAssertEqual(afterEachRan, 2);
  SPTAssertEqual(afterAllRan, 1);
}

@end
