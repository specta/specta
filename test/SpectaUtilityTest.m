#import "TestHelper.h"
#import "SpectaUtility.h"

SpecBegin(_SpectaUtilityTest)
SpecEnd

@interface SpectaUtilityTest : SenTestCase

@end

@implementation SpectaUtilityTest

- (void)test_SPT_IsSpecClass_returns_yes_when_provided_a_spec_class
{
  STAssertTrue(SPT_IsSpecClass([_SpectaUtilityTestSpec class]),
               @"SPT_IsSpecClass returns YES when provided a spec class");
}

- (void)test_SPT_IsSpecClass_returns_no_when_provided_a_sentest_class
{
  STAssertFalse(SPT_IsSpecClass([SpectaUtilityTest class]),
                @"SPT_IsSpecClass returns NO when provided a SenTest test class");
}

@end
