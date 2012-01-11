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
  NSArray *subclasses = [SenTestCase senAllSubclasses];
  BOOL contains = NO;
  for(Class klass in subclasses) {
    if(klass == [_MiscTestSpec class]) {
      contains = YES;
      break;
    }
  }
  expect(contains).toEqual(YES);
}

- (void)testSPTSenTestCaseNotInSenTestCaseSubClassList {
  // trick SenTestCase into thinking SPTSenTestCase is not a subclass of SenTestCase
  NSArray *subclasses = [SenTestCase senAllSubclasses];
  BOOL contains = NO;
  for(Class klass in subclasses) {
    if(klass == [SPTSenTestCase class]) {
      contains = YES;
      break;
    }
  }
  expect(contains).toEqual(NO);
}

@end
