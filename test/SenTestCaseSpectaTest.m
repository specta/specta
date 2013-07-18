#import "TestHelper.h"
#import "SenTestCase+Specta.h"

SpecBegin(_SenTestCaseSpectaTest)

describe(@"group", ^{
  it(@"example 1", ^{
    STAssertTrue(YES, @"YES is true");
  });
});

SpecEnd

@interface SenTestCaseSpectaTest : SenTestCase

@end

@implementation SenTestCaseSpectaTest

- (void)test_SPT_title_when_test_case_is_a_spec_example
{
  SenTestSuite * testSuite = [SenTestSuite testSuiteForTestCaseClass:[_SenTestCaseSpectaTestSpec class]];
  
  STAssertEquals((NSUInteger)[[testSuite valueForKey:@"tests"] count],
                 (NSUInteger)1,
                 @"Only one test exists in the sample spec");
  
  SPTSenTestCase * specExample = [[testSuite valueForKey:@"tests"] objectAtIndex:0];
  STAssertEqualObjects([specExample SPT_title],
                       @"group example 1",
                       @"Spec example titles equal the full example name");
}

- (void)test_SPT_title_when_test_case_is_a_sen_test_case
{
  SenTestSuite * testSuite = [SenTestSuite testSuiteForTestCaseClass:[SenTestCaseSpectaTest class]];
  
  NSArray * testCases = [testSuite valueForKey:@"tests"];
  
  NSString * thisTestCaseName = NSStringFromSelector(_cmd);
  NSUInteger thisTestCaseIndex =
    [testCases indexOfObjectPassingTest:^BOOL(id testCase, NSUInteger idx, BOOL *stop) {
      return [NSStringFromSelector([(SenTestCase *)testCase selector]) isEqualToString:thisTestCaseName];
    }];

  SenTestCase * thisTestCase = [testCases objectAtIndex:thisTestCaseIndex];
  
  STAssertEqualObjects([thisTestCase SPT_title],
                       thisTestCaseName,
                       @"Test case titles equal the test's selector");
}

@end
