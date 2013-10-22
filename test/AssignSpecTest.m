#import "TestHelper.h"

SpecBegin(_AssignSpecTest)

describe(@"assign", ^{
    
  assign(@"foo", ^{ return @"bar"; });
    
  it(@"accesses assgined block return value", ^{
    NSString *foo = getAssign(@"foo");
    expect(foo).toEqual(@"bar");
  });

});

SpecEnd

@interface AssignSpecTest : SenTestCase; @end
@implementation AssignSpecTest

- (void)testAssignSpec {
  SenTestRun *result = RunSpec(_AssignSpecTestSpec);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
}

@end