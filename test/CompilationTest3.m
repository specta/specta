#import "TestHelper.h"

static int
  example1Ran
, example2Ran
, example3Ran
, example4Ran
;

SpecBegin(_CompilationTest3)

describe(@"group 1", ^{
  context(@"group 2", ^{
    describe(@"group 3", ^{
      it(@"example 1", ^{
        example1Ran ++;
      });
    });

    it(@"example 2", ^{
      example2Ran ++;
    });
  });

  example(@"example 3", ^{
    example3Ran ++;
  });

  specify(@"example 4", ^{
    example4Ran ++;
  });
});

SpecEnd

@interface CompilationTest3 : SenTestCase; @end
@implementation CompilationTest3

- (void)testNestedExamples {
  example1Ran = example2Ran = example3Ran = example4Ran = 0;

  RunSpec(_CompilationTest3Spec);

  expect(example1Ran).toEqual(1);
  expect(example2Ran).toEqual(1);
  expect(example3Ran).toEqual(1);
  expect(example4Ran).toEqual(1);
}

@end
