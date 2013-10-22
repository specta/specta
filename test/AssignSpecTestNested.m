#import "TestHelper.h"

SpecBegin(_AssignSpecTestNested)

describe(@"outer assign", ^{
    
    assign(@"foo", ^{ return @"bar"; });
    
    describe(@"inner assign", ^{
        
        assign(@"foo", ^{ return @"baz"; });
        
        it(@"accesses inner assgined block return value", ^{
            NSString *foo = getAssign(@"foo");
            expect(foo).toEqual(@"baz");
        });
    });
    
    it(@"accesses outer assgined block return value", ^{
        NSString *foo = getAssign(@"foo");
        expect(foo).toEqual(@"bar");
    });
    
});

SpecEnd

@interface AssignSpecTestNested : SenTestCase; @end
@implementation AssignSpecTestNested

- (void)testAssignNestedSpec {
  SenTestRun *result = RunSpec(_AssignSpecTestNestedSpec);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
}

@end
