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
    if(beforeAllRan == 1 && beforeEachRan == 1 &&
       afterEachRan == 0 && afterAllRan == 0) {
      example1RanCorrectly ++;
    }
  });

  it(@"example 2", ^{
    if(beforeAllRan == 1 && beforeEachRan == 2 &&
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

@interface AsyncSpecTest2 : SenTestCase; @end
@implementation AsyncSpecTest2

- (void)testBeforeAllAndAfterAllHooks {
  beforeEachRan = afterEachRan = example1RanCorrectly = example2RanCorrectly = beforeAllRan = afterAllRan = 0;

  RunSpec(_AsyncSpecTest2Spec);

  expect(example1RanCorrectly).toEqual(1);
  expect(example2RanCorrectly).toEqual(1);

  expect(beforeAllRan).toEqual(1);
  expect(beforeEachRan).toEqual(2);
  expect(afterEachRan).toEqual(2);
  expect(afterAllRan).toEqual(1);
}

@end
