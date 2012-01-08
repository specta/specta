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

@interface DSLTest2 : SenTestCase; @end
@implementation DSLTest2

- (void)testBeforeAndAfterHooks {
  SPTExampleGroup *rootGroup = [_DSLTest2Spec SPT_spec].rootGroup;
  SPTExampleGroup *group = [rootGroup.children objectAtIndex:0];

  expect([group.beforeAllArray count]).toEqual(2);
  expect([group.beforeEachArray count]).toEqual(2);
  expect([group.afterEachArray count]).toEqual(2);
  expect([group.afterAllArray count]).toEqual(2);

  expect([group.beforeAllArray objectAtIndex:0]).toEqual(block1);
  expect([group.beforeEachArray objectAtIndex:0]).toEqual(block2);
  expect([group.afterEachArray objectAtIndex:0]).toEqual(block3);
  expect([group.afterAllArray objectAtIndex:0]).toEqual(block4);

  expect([group.beforeAllArray objectAtIndex:1]).toEqual(block5);
  expect([group.beforeEachArray objectAtIndex:1]).toEqual(block6);
  expect([group.afterEachArray objectAtIndex:1]).toEqual(block7);
  expect([group.afterAllArray objectAtIndex:1]).toEqual(block8);
}

@end
