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

@interface ReRunTest : SenTestCase; @end
@implementation ReRunTest

- (void)test_Tests_should_be_able_to_run_multiple_times {
  beforeEachRan = afterEachRan = example1Ran = example2Ran = beforeAllRan = afterAllRan = 0;

  RunSpec(_ReRunTestSpec);

  expect(example1Ran).toEqual(1);
  expect(example2Ran).toEqual(1);

  expect(beforeAllRan).toEqual(1);
  expect(beforeEachRan).toEqual(2);
  expect(afterEachRan).toEqual(2);
  expect(afterAllRan).toEqual(1);

  RunSpec(_ReRunTestSpec);

  expect(example1Ran).toEqual(2);
  expect(example2Ran).toEqual(2);

  expect(beforeAllRan).toEqual(2);
  expect(beforeEachRan).toEqual(4);
  expect(afterEachRan).toEqual(4);
  expect(afterAllRan).toEqual(2);
}

@end
