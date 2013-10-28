#import "TestHelper.h"

@interface XCTestCase (MiscTest)

+ (NSArray *)xct_allSubclasses;

@end

SpecBegin(_MiscTest)

describe(@"group", ^{
});

SpecEnd

@interface MiscTest : XCTestCase; @end
@implementation MiscTest

- (void)test_MiscTestSpecInXCTestCaseSubClassList {
  SPTAssertTrue([[XCTestCase xct_allSubclasses] indexOfObject:[_MiscTestSpec class]] != NSNotFound);
}

- (void)testSPTXCTestCaseNotInXCTestCaseSubClassList {
  // trick XCTestCase into thinking SPTXCTestCase is not a subclass of XCTestCase
  SPTAssertTrue([[XCTestCase xct_allSubclasses] indexOfObject:[SPTXCTestCase class]] == NSNotFound);
}

@end
