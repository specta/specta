#import "TestHelper.h"

static NSMutableArray *items;

SharedExamplesBegin(MoreGlobalSharedExamples)

sharedExamplesFor(@"overridden shared example 1", ^{
  it(@"adds bar to items", ^{
    [items addObject:@"bar"];
  });
});

sharedExamplesFor(@"overridden shared example 2", ^{
  it(@"adds baz to items", ^{
    [items addObject:@"baz"];
  });
});

SharedExamplesEnd

SpecBegin(_SharedExamplesTest3)

sharedExamplesFor(@"overridden shared example 1", ^{
  it(@"adds foo to items", ^{
    [items addObject:@"foo"];
  });
});

describe(@"overriding global shared examples with local shared examples", ^{
  itBehavesLike(@"overridden shared example 1", nil); // ['foo']
  itBehavesLike(@"overridden shared example 2", nil); // ['foo', 'baz']

  describe(@"another override", ^{
    sharedExamplesFor(@"overridden shared example 1", ^{
      it(@"adds qux to items", ^{
        [items addObject:@"qux"];
      });
    });

    sharedExamplesFor(@"overridden shared example 2", ^{
      it(@"adds faz to items", ^{
        [items addObject:@"faz"];
      });
    });

    itBehavesLike(@"overridden shared example 1", nil); // ['foo', 'baz', 'qux']
    itBehavesLike(@"overridden shared example 2", nil); // ['foo', 'baz', 'qux', 'faz']
  });

  itBehavesLike(@"overridden shared example 1", nil); // ['foo', 'baz', 'qux', 'faz', 'foo']
  itBehavesLike(@"overridden shared example 2", nil); // ['foo', 'baz', 'qux', 'faz', 'foo', 'baz']
});

SpecEnd

@interface SharedExamplesTest3 : SenTestCase; @end
@implementation SharedExamplesTest3

- (void)testSharedExamples {
  items = [[NSMutableArray alloc] init];
  RunSpec(_SharedExamplesTest3Spec);
  expect(items).toEqual(([NSArray arrayWithObjects:@"foo", @"baz", @"qux", @"faz", @"foo", @"baz", nil]));
  [items release];
  items = nil;
}

@end
