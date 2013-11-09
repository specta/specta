#import "TestHelper.h"

SpecBegin(_DSLTest3)

describe(@"group 1", ^{
  context(@"group 2", ^{});
  describe(@"group 3", ^{});
});

context(@"group 4", ^{});

SpecEnd

@interface DSLTest3 : XCTestCase; @end
@implementation DSLTest3

- (void)testNestedExampleGroups {
  SPTExampleGroup *rootGroup = [_DSLTest3Spec spt_spec].rootGroup;
  SPTAssertEqual([rootGroup.children count], 2);

  SPTExampleGroup *group1 = rootGroup.children[0];
  SPTAssertTrue([group1 isKindOfClass:[SPTExampleGroup class]]);
  SPTAssertEqualObjects(group1.name, @"group 1");
  SPTAssertEqualObjects(group1.parent, rootGroup);
  SPTAssertEqualObjects(group1.root, rootGroup);
  SPTAssertEqual([group1.children count], 2);

  SPTExampleGroup *group2 = group1.children[0];
  SPTExampleGroup *group3 = group1.children[1];

  SPTAssertTrue([group2 isKindOfClass:[SPTExampleGroup class]]);
  SPTAssertTrue([group3 isKindOfClass:[SPTExampleGroup class]]);
  SPTAssertEqualObjects(group2.name, @"group 2");
  SPTAssertEqualObjects(group3.name, @"group 3");
  SPTAssertEqualObjects(group2.parent, group1);
  SPTAssertEqualObjects(group3.parent, group1);
  SPTAssertEqualObjects(group2.root, rootGroup);
  SPTAssertEqualObjects(group3.root, rootGroup);

  SPTExampleGroup *group4 = rootGroup.children[1];
  SPTAssertTrue([group4 isKindOfClass:[SPTExampleGroup class]]);
  SPTAssertEqualObjects(group4.name, @"group 4");
  SPTAssertEqualObjects(group4.parent, rootGroup);
  SPTAssertEqualObjects(group4.root, rootGroup);
}

@end
