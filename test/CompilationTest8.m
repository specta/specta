#import "TestHelper.h"

SpecBegin(_CompilationTest8)

describe(@"group 1", ^{
  describe(@"group 2", ^{
    describe(@"group 3", ^{
      it(@"example 1", ^{});
      it(@"example 2", ^{});
    });
    it(@"example 3", ^{});
  });
  it(@"example 4", ^{});
  it(@"example 5", ^{});
  describe(@"group 4", ^{
    it(@"example 6", ^{});
  });
});

SpecEnd

@interface CompilationTest8 : XCTestCase; @end
@implementation CompilationTest8

- (void)testCompiledExampleNames {
  RunSpec(_CompilationTest8Spec);
  SPTSpec *spec = [_CompilationTest8Spec spt_spec];
  NSArray *compiledExamples = spec.compiledExamples;

  SPTAssertEqualObjects([compiledExamples[0] name], @"group 1 group 2 group 3 example 1");
  SPTAssertEqualObjects([compiledExamples[1] name], @"group 1 group 2 group 3 example 2");
  SPTAssertEqualObjects([compiledExamples[2] name], @"group 1 group 2 example 3");
  SPTAssertEqualObjects([compiledExamples[3] name], @"group 1 example 4");
  SPTAssertEqualObjects([compiledExamples[4] name], @"group 1 example 5");
  SPTAssertEqualObjects([compiledExamples[5] name], @"group 1 group 4 example 6");
}

@end
