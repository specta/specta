#import "TestHelper.h"

SpecBegin(_DSLTest1)

describe(@"group", ^{});

SpecEnd

@interface DSLTest1 : SenTestCase; @end
@implementation DSLTest1

- (void)testSingleExampleGroup {
  SPTExampleGroup *rootGroup = [_DSLTest1Spec SPT_spec].rootGroup;

  expect(rootGroup).toBeKindOf([SPTExampleGroup class]);
  expect(rootGroup.root).toEqual(rootGroup);
  expect(rootGroup.parent).toEqual(nil);

  expect([rootGroup.children count]).toEqual(1);
  SPTExampleGroup *group = [rootGroup.children objectAtIndex:0];
  expect(group.name).toEqual(@"group");
  expect(group.parent).toEqual(rootGroup);
  expect(group.root).toEqual(rootGroup);
}

@end
