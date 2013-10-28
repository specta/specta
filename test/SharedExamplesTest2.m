#import "TestHelper.h"

static NSMutableArray *items;
static NSString *foo;

SpecBegin(_SharedExamplesTest2)

describe(@"group", ^{
  itShouldBehaveLike(@"global shared 1",
                     @{@"foo" : @"Foo",
                       @"bar" : @"Bar"});
});

itBehavesLike(@"global shared 2", @{@"baz": @"hello"});

context(@"group2", ^{
  itBehavesLike(@"global shared 2", @{@"baz": @"world"});
});

SpecEnd

SharedExamplesBegin(GlobalSharedExamples1)

sharedExamplesFor(@"global shared 1", ^(NSDictionary *data) {
  describe(@"foo", ^{
    it(@"equals string 'Foo'", ^{
      SPTAssertEqualObjects(data[@"foo"], foo);
    });
  });

  describe(@"bar", ^{
    it(@"equals string 'Bar'", ^{
      SPTAssertEqualObjects(data[@"bar"], @"Bar");
    });
  });
});

SharedExamplesEnd

SharedExamplesBegin(GlobalSharedExamples2)

sharedExamples(@"global shared 2", ^(NSDictionary *data) {
  it(@"inserts data.baz to items", ^{
    [items addObject:data[@"baz"]];
  });
});

SharedExamplesEnd

@interface SharedExamplesTest2 : XCTestCase; @end
@implementation SharedExamplesTest2

- (void)testSharedExamples {
  foo = @"Not Foo";
  items = [[NSMutableArray alloc] init];
  XCTestSuiteRun *result = RunSpec(_SharedExamplesTest2Spec);
  SPTAssertEqual([result testCaseCount], 4);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 1);
  SPTAssertFalse([result hasSucceeded]);
  SPTAssertEqualObjects(items, (@[@"hello", @"world"]));
  items = nil;
  foo = @"Foo";
}

@end
