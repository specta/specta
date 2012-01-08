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

@interface DSLTest5 : SenTestCase; @end
@implementation DSLTest5

- (void)testNestedExamples {
  SPTExampleGroup *rootGroup = [_DSLTest5Spec SPT_spec].rootGroup;

  SPTExampleGroup *group1 = [rootGroup.children objectAtIndex:0];
  expect(group1.name).toEqual(@"group 1");
  expect([group1.children count]).toEqual(2);

  SPTExampleGroup *group2 = [group1.children objectAtIndex:0];
  expect(group2.name).toEqual(@"group 2");
  expect([group2.children count]).toEqual(2);

  SPTExample *example1 = [group2.children objectAtIndex:0];
  SPTExample *example2 = [group2.children objectAtIndex:1];
  SPTExample *example3 = [group1.children objectAtIndex:1];

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
