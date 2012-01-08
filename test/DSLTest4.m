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

@interface DSLTest4 : SenTestCase; @end
@implementation DSLTest4

- (void)testExamples {
  SPTExampleGroup *rootGroup = [_DSLTest4Spec SPT_spec].rootGroup;
  SPTExampleGroup *group = [rootGroup.children objectAtIndex:0];

  expect([group.children count]).toEqual(3);

  SPTExample *example1 = [group.children objectAtIndex:0];
  SPTExample *example2 = [group.children objectAtIndex:1];
  SPTExample *example3 = [group.children objectAtIndex:2];

  expect(example1).toBeKindOf([SPTExample class]);
  expect(example2).toBeKindOf([SPTExample class]);
  expect(example3).toBeKindOf([SPTExample class]);

  expect(example1.name).toEqual(@"example 1");
  expect(example2.name).toEqual(@"example 2");
  expect(example3.name).toEqual(@"example 3");

  expect(example1.block).toEqual(block1);
  expect(example2.block).toEqual(block2);
  expect(example3.block).toEqual(block3);
}

@end
