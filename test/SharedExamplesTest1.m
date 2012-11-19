#import "TestHelper.h"

static NSMutableArray *items;

SpecBegin(_SharedExamplesTest1)

sharedExamplesFor(@"shared1", ^(NSDictionary * (^dataInject)(void)) {
  describe(@"foo", ^{
    it(@"equals string 'Foo'", ^{
      NSDictionary *data = dataInject();
      expect([data objectForKey:@"foo"]).toEqual(@"Foo");
    });
  });

  describe(@"bar", ^{
    it(@"equals string 'Bar'", ^{
      NSDictionary *data = dataInject();
      expect([data objectForKey:@"bar"]).toEqual(@"Bar");
    });
  });
});

sharedExamples(@"shared2", ^(NSDictionary * (^dataInject)(void)) {
  it(@"inserts data.baz to items", ^{
    NSDictionary *data = dataInject();
    [items addObject:[data objectForKey:@"baz"]];
  });
});

describe(@"group", ^{
  itShouldBehaveLike(@"shared1", ^{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Foo", @"foo",
								@"Bar", @"bar", nil];
  });
});

itBehavesLike(@"shared2", ^{
  return [NSDictionary dictionaryWithObject:@"hello" forKey:@"baz"];
});

context(@"group2", ^{
  itBehavesLike(@"shared2", ^{
    return [NSDictionary dictionaryWithObject:@"world" forKey:@"baz"];
  });
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
