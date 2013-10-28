#import "TestHelper.h"
#import "SpectaUtility.h"

SpecBegin(_SpectaUtilityTest)
SpecEnd

@interface SpectaUtilityTest : XCTestCase
@end

@implementation SpectaUtilityTest

- (void)test_SPTIsSpecClass_returns_yes_when_provided_a_spec_class {
  SPTAssertTrue(SPTIsSpecClass([_SpectaUtilityTestSpec class]));
}

- (void)test_SPTIsSpecClass_returns_no_when_provided_a_XCTest_class {
  SPTAssertFalse(SPTIsSpecClass([SpectaUtilityTest class]));
}

@end
