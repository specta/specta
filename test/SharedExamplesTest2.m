#import "TestHelper.h"

static NSMutableArray *items;

SpecBegin(_SharedExamplesTest2)

describe(@"group", ^{
  itShouldBehaveLike(@"global shared 1",
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Foo", @"foo",
                                                                @"Bar", @"bar", nil]);
});

itBehavesLike(@"global shared 2", [NSDictionary dictionaryWithObject:@"hello" forKey:@"baz"]);

context(@"group2", ^{
  itBehavesLike(@"global shared 2", [NSDictionary dictionaryWithObject:@"world" forKey:@"baz"]);
});

SpecEnd

SharedExamplesBegin(GlobalSharedExamples1)

sharedExamplesFor(@"global shared 1", ^(NSDictionary *data) {
  describe(@"foo", ^{
    it(@"equals string 'Foo'", ^{
      expect([data objectForKey:@"foo"]).toEqual(@"Foo");
    });
  });

  describe(@"bar", ^{
    it(@"equals string 'Bar'", ^{
      expect([data objectForKey:@"bar"]).toEqual(@"Bar");
    });
  });
});

SharedExamplesEnd

SharedExamplesBegin(GlobalSharedExamples2)

sharedExamples(@"global shared 2", ^(NSDictionary *data) {
  it(@"inserts data.baz to items", ^{
    [items addObject:[data objectForKey:@"baz"]];
  });
});

SharedExamplesEnd

@interface SharedExamplesTest2 : SenTestCase; @end
@implementation SharedExamplesTest2

- (void)testSharedExamples {
  items = [[NSMutableArray alloc] init];
  SenTestSuiteRun *result = RunSpec(_SharedExamplesTest2Spec);
  expect([result testCaseCount]).toEqual(4);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
  expect(items).toEqual(([NSArray arrayWithObjects:@"hello", @"world", nil]));
  [items release];
  items = nil;
}

@end
