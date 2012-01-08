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
    if(beforeEachRan == 1 && afterEachRan == 0) {
      example1RanCorrectly ++;
    }
  });

  it(@"example 2", ^{
    if(beforeEachRan == 2 && afterEachRan == 1) {
      example2RanCorrectly ++;
    }
  });

  afterEach(^{
    afterEachRan ++;
  });
});

SpecEnd

@interface CompilationTest4 : SenTestCase; @end
@implementation CompilationTest4

- (void)testBeforeEachAndAfterEachHooks {
  beforeEachRan = afterEachRan = example1RanCorrectly = example2RanCorrectly = 0;

  RunSpec(_CompilationTest4Spec);

  expect(example1RanCorrectly).toEqual(1);
  expect(example2RanCorrectly).toEqual(1);

  expect(beforeEachRan).toEqual(2);
  expect(afterEachRan).toEqual(2);
}

@end
