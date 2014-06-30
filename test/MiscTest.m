#import "TestHelper.h"

#ifdef _SPT_XCODE6
  #define spt_allSubclasses allSubclasses
#else
  #define spt_allSubclasses xct_allSubclasses
#endif

@interface XCTestCase (MiscTest)

+ (NSArray *)spt_allSubclasses;

@end

SpecBegin(_MiscTest)

describe(@"group", ^{
});

SpecEnd

@interface MiscTest : XCTestCase; @end
@implementation MiscTest

- (void)test_MiscTestSpecInXCTestCaseSubClassList {
  SPTAssertTrue([[XCTestCase spt_allSubclasses] indexOfObject:[_MiscTestSpec class]] != NSNotFound);
}

- (void)testSPTTestCaseNotInXCTestCaseSubClassList {
  // trick XCTestCase into thinking SPTTestCase is not a subclass of XCTestCase
  SPTAssertTrue([[XCTestCase spt_allSubclasses] indexOfObject:[SPTTestCase class]] == NSNotFound);
}

@end
