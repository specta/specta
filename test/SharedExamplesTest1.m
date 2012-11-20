#import "TestHelper.h"

static NSMutableArray *items;

SpecBegin(_SharedExamplesTest1)

sharedExamplesFor(@"shared1", ^(id foo, id bar) {
  describe(@"foo", ^{
    it(@"equals string 'Foo'", ^{
      expect(foo).toEqual(@"Foo");
    });
  });

  describe(@"bar", ^{
    it(@"equals string 'Bar'", ^{
      expect(bar).toEqual(@"Bar");
    });
  });
});

sharedExamples(@"shared2", ^(id baz) {
  it(@"inserts data.baz to items", ^{
    [items addObject:baz];
  });
});

describe(@"group", ^{
  itShouldBehaveLike(@"shared1", @"Foo", @"Bar", nil);
});

itBehavesLike(@"shared2", @"hello", nil);

context(@"group2", ^{
  itBehavesLike(@"shared2", @"world", nil);
});

SpecEnd

@interface SharedExamplesTest1 : SenTestCase; @end
@implementation SharedExamplesTest1

- (void)testSharedExamples {
  items = [[NSMutableArray alloc] init];
  SenTestSuiteRun *result = RunSpec(_SharedExamplesTest1Spec);
  expect([result testCaseCount]).toEqual(4);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
  expect(items).toEqual(([NSArray arrayWithObjects:@"hello", @"world", nil]));
  [items release];
  items = nil;
}

@end
