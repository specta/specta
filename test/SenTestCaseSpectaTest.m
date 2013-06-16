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

- (void)test_SPT_testCasePathname_when_test_case_exists
{
  NSString * pathnameForTestClass = [SenTestCaseSpectaTest SPT_testCasePathname];
  
  STAssertEqualObjects(pathnameForTestClass,
                       [NSString stringWithUTF8String:__FILE__],
                       @"[SenTestCase SPT_testCasePathname] returns the path of the test case (when possible)");
}

- (void)test_SPT_testCasePathname_when_test_case_doesnt_exist
{
  NSString * pathnameForSpecClass = [_SenTestCaseSpectaTestSpec SPT_testCasePathname];
  
  NSString * expectedPathName = [NSString stringWithUTF8String:__FILE__];
  expectedPathName = [expectedPathName stringByDeletingLastPathComponent]; // remove the .m file
  expectedPathName = [expectedPathName stringByDeletingLastPathComponent]; // remove the test/ directory
  expectedPathName = [expectedPathName stringByAppendingPathComponent:@"_SenTestCaseSpectaTestSpec.m"];
  
  STAssertEqualObjects(pathnameForSpecClass,
                       expectedPathName,
                       @"[SenTestCase SPT_testCasePathname] returns a guessed path name in the project directory when "
                        "the spec file can't be found.");
}

- (void)test_SPT_title_when_test_case_is_a_spec_example
{
  SenTestSuite * testSuite = [SenTestSuite testSuiteForTestCaseClass:[_SenTestCaseSpectaTestSpec class]];
  
  STAssertEquals([[testSuite valueForKey:@"tests"] count], 1UL,
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
    [testCases indexOfObjectPassingTest:^BOOL(SenTestCase * testCase, NSUInteger idx, BOOL *stop) {
      return [NSStringFromSelector(testCase.selector) isEqualToString:thisTestCaseName];
    }];
  
  SenTestCase * thisTestCase = [testCases objectAtIndex:thisTestCaseIndex];
  
  STAssertEqualObjects([thisTestCase SPT_title],
                       thisTestCaseName,
                       @"Test case titles equal the test's selector");
}

@end
