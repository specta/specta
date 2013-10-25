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

@interface CompilationTest8 : SenTestCase; @end
@implementation CompilationTest8

- (void)testCompiledExampleNames {
  RunSpec(_CompilationTest8Spec);
  SPTSpec *spec = [_CompilationTest8Spec SPT_spec];
  NSArray *compiledExamples = spec.compiledExamples;

  expect([compiledExamples[0] name]).toEqual(@"group 1 group 2 group 3 example 1");
  expect([compiledExamples[1] name]).toEqual(@"group 1 group 2 group 3 example 2");
  expect([compiledExamples[2] name]).toEqual(@"group 1 group 2 example 3");
  expect([compiledExamples[3] name]).toEqual(@"group 1 example 4");
  expect([compiledExamples[4] name]).toEqual(@"group 1 example 5");
  expect([compiledExamples[5] name]).toEqual(@"group 1 group 4 example 6");
}

@end
