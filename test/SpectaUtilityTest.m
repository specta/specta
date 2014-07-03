#import "TestHelper.h"
#import "SpectaUtility.h"

SpecBegin(_SpectaUtilityTest)
SpecEnd

@interface SpectaUtilityTest : XCTestCase
@end

@implementation SpectaUtilityTest

- (void)test_spt_isTestCaseClass_returns_yes_when_provided_a_spec_class {
  assertTrue(spt_isTestCaseClass([_SpectaUtilityTestSpec class]));
}

- (void)test_spt_isTestCaseClass_returns_no_when_provided_a_XCTest_class {
  assertFalse(spt_isTestCaseClass([SpectaUtilityTest class]));
}

@end
