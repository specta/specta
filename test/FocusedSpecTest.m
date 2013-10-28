#import "TestHelper.h"
#import "SPTExample.h"

SpecBegin(_FocusedSpecTest)

// disable this spec to prevent it from infecting other specs in our test bundle
[[self class] spt_setDisabled:YES];

describe(@"root", ^{

  it(@"unfocused example", ^{
    SPTAssertFalse(YES);
  });

  fit(@"focused example", ^{
    SPTAssertTrue(YES);
  });

  fdescribe(@"focused group", ^{
    it(@"focused child example", ^{
      XCTAssertTrue(YES, @"child examples are run when contained in a focused group");
    });
  });
});

SpecEnd

@interface FocusedSpecTest : XCTestCase
@end

@implementation FocusedSpecTest

- (void)test_focused_examples_are_focused {
  XCTAssertFalse([SPTXCTestCase spt_focusedExamplesExist], @"Focused examples should not exist if the spec is disabled");

  SPTSpec *spec = [_FocusedSpecTestSpec spt_spec];
  SPTAssertTrue(spec.hasFocusedExamples);

  SPTExampleGroup *specGroup = spec.rootGroup;

  SPTExampleGroup *rootGroup = specGroup.children[0];

  SPTExample *unfocusedExample = [rootGroup children][0];
  XCTAssertFalse([unfocusedExample isFocused], @"by default, examples are not focused");

  SPTExample *focusedExample = [rootGroup children][1];
  XCTAssertTrue([focusedExample isFocused], @"when prefixed with an 'f', examples are focused");

  SPTExampleGroup *focusedExampleGroup = [rootGroup children][2];
  XCTAssertTrue([focusedExampleGroup isFocused], @"when prefixed with an 'f', groups are focused");
}

- (void)test_compiled_examples_are_focused {
  SPTSpec *spec = [_FocusedSpecTestSpec spt_spec];
  XCTAssert([spec.compiledExamples count] == 3, @"All examples are compiled, focused or not");

  SPTExample *compiledUnfocusedExample = (spec.compiledExamples)[0];
  XCTAssertFalse([compiledUnfocusedExample isFocused], @"unfocused examples are not focused when compiled");

  SPTExample *compiledFocusedExample = (spec.compiledExamples)[1];
  XCTAssertTrue([compiledFocusedExample isFocused], @"focused examples are focused when compiled");

  SPTExample *compiledInheritedFocusedExample = (spec.compiledExamples)[2];
  XCTAssertTrue([compiledInheritedFocusedExample isFocused], @"examples within focused groups are focused when compiled");
}

- (void)test_focused_specs_are_run_exclusively {
  [_FocusedSpecTestSpec spt_setDisabled:NO];
  XCTestSuiteRun *result = RunSpec(_FocusedSpecTestSpec);
  [_FocusedSpecTestSpec spt_setDisabled:YES];

  SPTAssertEqual([result testCaseCount], 3);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
  // SPTAssertEqual([result pendingTestCaseCount], 0);
  // SPTAssertEqual([result skippedTestCaseCount], 1);
}

@end
