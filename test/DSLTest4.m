#import "TestHelper.h"
#import "SPTExample.h"

static SPTVoidBlock
  block1 = ^{}
, block2 = ^{}
, block3 = ^{}
;

SpecBegin(_DSLTest4)

describe(@"group", ^{
  it(@"example 1", block1);
  example(@"example 2", block2);
  specify(@"example 3", block3);
});

SpecEnd

@interface DSLTest4 : XCTestCase; @end
@implementation DSLTest4

- (void)testExamples {
  SPTExampleGroup *rootGroup = [_DSLTest4Spec spt_spec].rootGroup;
  SPTExampleGroup *group = rootGroup.children[0];

  SPTAssertEqual([group.children count], 3);

  SPTExample *example1 = group.children[0];
  SPTExample *example2 = group.children[1];
  SPTExample *example3 = group.children[2];

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
