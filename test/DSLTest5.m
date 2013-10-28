#import "TestHelper.h"
#import "SPTExample.h"

static SPTVoidBlock
  block1 = ^{}
, block2 = ^{}
, block3 = ^{}
;

SpecBegin(_DSLTest5)

describe(@"group 1", ^{
  describe(@"group 2", ^{
    it(@"example 1", block1);
    example(@"example 2", block2);
  });

  specify(@"example 3", block3);
});

SpecEnd

@interface DSLTest5 : XCTestCase; @end
@implementation DSLTest5

- (void)testNestedExamples {
  SPTExampleGroup *rootGroup = [_DSLTest5Spec spt_spec].rootGroup;

  SPTExampleGroup *group1 = rootGroup.children[0];
  SPTAssertEqualObjects(group1.name, @"group 1");
  SPTAssertEqual([group1.children count], 2);

  SPTExampleGroup *group2 = group1.children[0];
  SPTAssertEqualObjects(group2.name, @"group 2");
  SPTAssertEqual([group2.children count], 2);

  SPTExample *example1 = group2.children[0];
  SPTExample *example2 = group2.children[1];
  SPTExample *example3 = group1.children[1];

  SPTAssertTrue([example1 isKindOfClass:[SPTExample class]]);
  SPTAssertTrue([example2 isKindOfClass:[SPTExample class]]);
  SPTAssertTrue([example3 isKindOfClass:[SPTExample class]]);

  SPTAssertEqualObjects(example1.name, @"example 1");
  SPTAssertEqualObjects(example2.name, @"example 2");
  SPTAssertEqualObjects(example3.name, @"example 3");

  SPTAssertEqualObjects(example1.block, block1);
  SPTAssertEqualObjects(example2.block, block2);
  SPTAssertEqualObjects(example3.block, block3);
}

@end
