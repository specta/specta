#import "TestHelper.h"

@interface NSObject (MiscTest)

+ (NSArray *)senAllSubclasses;

@end

SpecBegin(_MiscTest)

describe(@"group", ^{
});

SpecEnd

@interface MiscTest : SenTestCase; @end
@implementation MiscTest

- (void)test_MiscTestSpecInSenTestCaseSubClassList {
  expect([SenTestCase senAllSubclasses]).toContain([_MiscTestSpec class]);
}

- (void)testSPTSenTestCaseNotInSenTestCaseSubClassList {
  // trick SenTestCase into thinking SPTSenTestCase is not a subclass of SenTestCase
  expect([SenTestCase senAllSubclasses]).Not.toContain([SPTSenTestCase class]);
}

@end
