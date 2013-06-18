#import "TestHelper.h"

SpecBegin(_FocusedSpecTest)

// disable this spec to prevent it from infecting other specs in our test bundle
[[self class] SPT_setDisabled:YES];

describe(@"root", ^{
  
  it(@"unfocused example", ^{
    STAssertFalse(YES, @"YES is false");
  });
  
  fit(@"focused example", ^{
    STAssertTrue(YES, @"YES is true");
  });
  
  fdescribe(@"focused group", ^{
    
    it(@"focused child example", ^{
      STAssertTrue(YES, @"child examples are run when contained in a focused group");
    });
    
  });
  
});

SpecEnd

@interface FocusedSpecTest : SenTestCase

@end

@implementation FocusedSpecTest

- (void)test_focused_examples_are_focused
{
  STAssertFalse([SPTSenTestCase SPT_focusedExamplesExist],
                @"Focused examples should not exist if the spec is disabled");
  
  SPTSpec * spec = [_FocusedSpecTestSpec SPT_spec];
  STAssertTrue(spec.hasFocusedExamples, @"focused examples exist");
  
  SPTExampleGroup * specGroup = spec.rootGroup;

  SPTExampleGroup * rootGroup = [specGroup.children objectAtIndex:0];

  SPTExample * unfocusedExample = [[rootGroup children] objectAtIndex:0];
  STAssertFalse([unfocusedExample isFocused],
                @"by default, examples are not focused");
  
  SPTExample * focusedExample = [[rootGroup children] objectAtIndex:1];
  STAssertTrue([focusedExample isFocused],
                @"when prefixed with an 'f', examples are focused");
  
  SPTExampleGroup * focusedExampleGroup = [[rootGroup children] objectAtIndex:2];
  STAssertTrue([focusedExampleGroup isFocused],
               @"when prefixed with an 'f', groups are focused");

}

- (void)test_compiled_examples_are_focused
{
  SPTSpec * spec = [_FocusedSpecTestSpec SPT_spec];
  STAssertEquals((NSUInteger)[spec.compiledExamples count],
                 (NSUInteger)3,
                 @"All examples are compiled, focused or not");
  
  SPTExample * compiledUnfocusedExample = [spec.compiledExamples objectAtIndex:0];
  STAssertFalse([compiledUnfocusedExample isFocused],
                @"unfocused examples are not focused when compiled");
  
  SPTExample * compiledFocusedExample = [spec.compiledExamples objectAtIndex:1];
  STAssertTrue([compiledFocusedExample isFocused],
                @"focused examples are focused when compiled");
  
  SPTExample * compiledInheritedFocusedExample = [spec.compiledExamples objectAtIndex:2];
  STAssertTrue([compiledInheritedFocusedExample isFocused],
               @"examples within focused groups are focused when compiled");
}

- (void)test_focused_specs_are_run_exclusively
{
  [_FocusedSpecTestSpec SPT_setDisabled:NO];
  SenTestSuiteRun *result = RunSpec(_FocusedSpecTestSpec);
  [_FocusedSpecTestSpec SPT_setDisabled:YES];
  
  expect([result testCaseCount]).toEqual(3);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
  expect([result pendingTestCaseCount]).toEqual(0);
  expect([result skippedTestCaseCount]).toEqual(1);
}

@end
