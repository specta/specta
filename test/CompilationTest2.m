#import "TestHelper.h"

static int
  example1Ran
, example2Ran
, example3Ran
, example4Ran
;

SpecBegin(_CompilationTest2)

describe(@"group", ^{
  it(@"example 1", ^{
    example1Ran ++;
  });

  it(@"example 2", ^{
    example2Ran ++;
  });

  example(@"example 3", ^{
    example3Ran ++;
  });

  specify(@"example 4", ^{
    example4Ran ++;
  });
});

SpecEnd

@interface CompilationTest2 : XCTestCase; @end
@implementation CompilationTest2

- (void)testMultipleExamples {
  example1Ran = example2Ran = example3Ran = example4Ran = 0;

  RunSpec(_CompilationTest2Spec);

  SPTAssertEqual(example1Ran, 1);
  SPTAssertEqual(example2Ran, 1);
  SPTAssertEqual(example3Ran, 1);
  SPTAssertEqual(example4Ran, 1);
}

@end
