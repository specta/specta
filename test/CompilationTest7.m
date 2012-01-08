#import "TestHelper.h"

static int
  beforeAllRan
, beforeAll2Ran
, example1RanCorrectly
, example2RanCorrectly
, afterAllRan
, afterAll2Ran
;

SpecBegin(_CompilationTest7)

describe(@"group", ^{
  beforeAll(^{
    beforeAllRan ++;
  });

  beforeAll(^{
    beforeAll2Ran ++;
  });

  it(@"example 1", ^{
    if(beforeAllRan == 1 && beforeAll2Ran == 1 &&
       afterAllRan == 0 && afterAll2Ran == 0) {
      example1RanCorrectly ++;
    }
  });

  it(@"example 2", ^{
    if(beforeAllRan == 1 && beforeAll2Ran == 1 &&
       afterAllRan == 0 && afterAll2Ran == 0) {
      example2RanCorrectly ++;
    }
  });

  afterAll(^{
    afterAllRan ++;
  });

  afterAll(^{
    afterAll2Ran ++;
  });
});

SpecEnd

@interface CompilationTest7 : SenTestCase; @end
@implementation CompilationTest7

- (void)testMultipleBeforeAllAndAfterAllHooks {
  beforeAllRan = afterAllRan = example1RanCorrectly = example2RanCorrectly = beforeAll2Ran = afterAll2Ran = 0;

  RunSpec(_CompilationTest7Spec);

  expect(example1RanCorrectly).toEqual(1);
  expect(example2RanCorrectly).toEqual(1);

  expect(beforeAllRan).toEqual(1);
  expect(beforeAll2Ran).toEqual(1);
  expect(afterAllRan).toEqual(1);
  expect(afterAll2Ran).toEqual(1);
}

@end
