#import "TestHelper.h"

SpecBegin(_DSLTest1)

describe(@"group", ^{});

SpecEnd

@interface DSLTest1 : XCTestCase; @end
@implementation DSLTest1

- (void)testSingleExampleGroup {
  SPTExampleGroup *rootGroup = [_DSLTest1Spec spt_spec].rootGroup;

  SPTAssertTrue([rootGroup isKindOfClass:[SPTExampleGroup class]]);
  SPTAssertEqualObjects(rootGroup.root, rootGroup);
  SPTAssertNil(rootGroup.parent);

  SPTAssertEqual([rootGroup.children count], 1);
  SPTExampleGroup *group = rootGroup.children[0];
  SPTAssertEqualObjects(group.name, @"group");
  SPTAssertEqualObjects(group.parent, rootGroup);
  SPTAssertEqualObjects(group.root, rootGroup);
}

@end
