#import "TestHelper.h"

static int
  beforeAllRan
, beforeEachRan
, example1RanCorrectly
, example2RanCorrectly
, afterEachRan
, afterAllRan
;

SpecBegin(_CompilationTest6)

describe(@"group", ^{
  beforeAll(^{
    beforeAllRan ++;
  });

  beforeEach(^{
    beforeEachRan ++;
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

  afterEach(^{
    afterEachRan ++;
  });

  afterAll(^{
    afterAllRan ++;
  });
});

SpecEnd

@interface CompilationTest6 : SenTestCase; @end
@implementation CompilationTest6

- (void)testBeforeAllAndAfterAllHooks {
  beforeEachRan = afterEachRan = example1RanCorrectly = example2RanCorrectly = beforeAllRan = afterAllRan = 0;

  RunSpec(_CompilationTest6Spec);

  expect(example1RanCorrectly).toEqual(1);
  expect(example2RanCorrectly).toEqual(1);

  expect(beforeAllRan).toEqual(1);
  expect(beforeEachRan).toEqual(2);
  expect(afterEachRan).toEqual(2);
  expect(afterAllRan).toEqual(1);
}

@end
