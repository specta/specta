#import "TestHelper.h"

SpecBegin(_DSLTest3)

describe(@"group 1", ^{
  context(@"group 2", ^{});
  describe(@"group 3", ^{});
});

context(@"group 4", ^{});

SpecEnd

@interface DSLTest3 : SenTestCase; @end
@implementation DSLTest3

- (void)testNestedExampleGroups {
  SPTExampleGroup *rootGroup = [_DSLTest3Spec SPT_spec].rootGroup;
  expect([rootGroup.children count]).toEqual(2);

  SPTExampleGroup *group1 = [rootGroup.children objectAtIndex:0];
  expect(group1).toBeKindOf([SPTExampleGroup class]);
  expect(group1.name).toEqual(@"group 1");
  expect(group1.parent).toEqual(rootGroup);
  expect(group1.root).toEqual(rootGroup);
  expect([group1.children count]).toEqual(2);

  SPTExampleGroup *group2 = [group1.children objectAtIndex:0];
  SPTExampleGroup *group3 = [group1.children objectAtIndex:1];

  expect(group2).toBeKindOf([SPTExampleGroup class]);
  expect(group3).toBeKindOf([SPTExampleGroup class]);
  expect(group2.name).toEqual(@"group 2");
  expect(group3.name).toEqual(@"group 3");
  expect(group2.parent).toEqual(group1);
  expect(group3.parent).toEqual(group1);
  expect(group2.root).toEqual(rootGroup);
  expect(group3.root).toEqual(rootGroup);

  SPTExampleGroup *group4 = [rootGroup.children objectAtIndex:1];
  expect(group4).toBeKindOf([SPTExampleGroup class]);
  expect(group4.name).toEqual(@"group 4");
  expect(group4.parent).toEqual(rootGroup);
  expect(group4.root).toEqual(rootGroup);
}

@end
