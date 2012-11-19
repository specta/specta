#import "TestHelper.h"

static NSMutableArray *items;

SpecBegin(_SharedExamplesTest2)

describe(@"group", ^{
  __block id delayedObj;
  beforeEach(^{
    delayedObj = [NSNumber numberWithInt:42];
  });

  itShouldBehaveLike(@"global shared 1", ^{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Foo", @"foo", @"Bar", @"bar", delayedObj, @"Delay", nil];
  });
});

itBehavesLike(@"global shared 2", ^{
  return [NSDictionary dictionaryWithObject:@"hello" forKey:@"baz"];
});

context(@"group2", ^{
  itBehavesLike(@"global shared 2", ^{
    return [NSDictionary dictionaryWithObject:@"world" forKey:@"baz"];
  });
});

SpecEnd

SharedExamplesBegin(GlobalSharedExamples1)

sharedExamplesFor(@"global shared 1", ^(NSDictionary * (^dataInject)(void)) {
  describe(@"foo", ^{
    it(@"equals string 'Foo'", ^{
      NSDictionary *data = dataInject();
      expect([data objectForKey:@"foo"]).toEqual(@"Foo");
      expect([data objectForKey:@"Delay"]).toEqual([NSNumber numberWithInt:42]);
    });
  });

  describe(@"bar", ^{
    it(@"equals string 'Bar'", ^{
      NSDictionary *data = dataInject();
      expect([data objectForKey:@"bar"]).toEqual(@"Bar");
    });
  });
});

SharedExamplesEnd

SharedExamplesBegin(GlobalSharedExamples2)

sharedExamples(@"global shared 2", ^(NSDictionary * (^dataInject)(void)) {
  it(@"inserts data.baz to items", ^{
    NSDictionary *data = dataInject();
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
