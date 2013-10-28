#import "TestHelper.h"

static SPTVoidBlock
  block1 = ^{}
, block2 = ^{}
, block3 = ^{}
, block4 = ^{}
, block5 = ^{}
, block6 = ^{}
, block7 = ^{}
, block8 = ^{}
;

SpecBegin(_DSLTest2)

describe(@"group", ^{
  beforeAll(block1);
  beforeEach(block2);
  afterEach(block3);
  afterAll(block4);
  beforeAll(block5);
  beforeEach(block6);
  afterEach(block7);
  afterAll(block8);
});

SpecEnd

@interface DSLTest2 : XCTestCase; @end
@implementation DSLTest2

- (void)testBeforeAndAfterHooks {
  SPTExampleGroup *rootGroup = [_DSLTest2Spec spt_spec].rootGroup;
  SPTExampleGroup *group = rootGroup.children[0];

  SPTAssertEqual([group.beforeAllArray count], 2);
  SPTAssertEqual([group.beforeEachArray count], 2);
  SPTAssertEqual([group.afterEachArray count], 2);
  SPTAssertEqual([group.afterAllArray count], 2);

  SPTAssertEqualObjects(group.beforeAllArray[0], block1);
  SPTAssertEqualObjects(group.beforeEachArray[0], block2);
  SPTAssertEqualObjects(group.afterEachArray[0], block3);
  SPTAssertEqualObjects(group.afterAllArray[0], block4);

  SPTAssertEqualObjects(group.beforeAllArray[1], block5);
  SPTAssertEqualObjects(group.beforeEachArray[1], block6);
  SPTAssertEqualObjects(group.afterEachArray[1], block7);
  SPTAssertEqualObjects(group.afterAllArray[1], block8);
}

@end
