#import "TestHelper.h"

static NSMutableArray *items;

SpecBegin(_SharedExamplesTest2)

describe(@"group", ^{
  __block id delayedObj;
  beforeEach(^{
    delayedObj = [NSNumber numberWithInt:42];
  });

  itShouldBehaveLike(@"global shared 1", @"Foo", @"Bar", [^{ return delayedObj; } copy], nil);
});

itBehavesLike(@"global shared 2", @"hello", nil);

context(@"group2", ^{
  itBehavesLike(@"global shared 2", @"world", nil);
});

SpecEnd

SharedExamplesBegin(GlobalSharedExamples1)

sharedExamplesFor(@"global shared 1", ^(id foo, id bar, id (^delayed)(void)) {
  describe(@"foo", ^{
    it(@"equals string 'Foo'", ^{
      expect(foo).toEqual(@"Foo");
      expect(delayed()).toEqual([NSNumber numberWithInt:42]);
    });
  });

  describe(@"bar", ^{
    it(@"equals string 'Bar'", ^{
      expect(bar).toEqual(@"Bar");
    });
  });
});

SharedExamplesEnd

SharedExamplesBegin(GlobalSharedExamples2)

sharedExamples(@"global shared 2", ^(id baz) {
  it(@"inserts baz to items", ^{
    [items addObject:baz];
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
