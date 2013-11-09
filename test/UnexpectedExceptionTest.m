#import "TestHelper.h"
#import <TargetConditionals.h>

static BOOL shouldRaiseException = NO;
static BOOL invokedAfterEach = NO;
static BOOL invokedAfterAll = NO;

static void raiseException() {
  [[NSException exceptionWithName:@"MyException" reason:@"Oh Noes! %@" userInfo:nil] raise];
}

SpecBegin(_UnexpectedExceptionTest)

describe(@"group", ^{

  afterEach(^{
    invokedAfterEach = YES;
  });

  afterAll(^{
    invokedAfterAll = YES;
  });

  it(@"example 1", ^{
    if (shouldRaiseException) {
      raiseException();
    }
  });
});

SpecEnd

@interface UnexpectedExceptionTest : XCTestCase; @end
@implementation UnexpectedExceptionTest

- (void)setUp {
  invokedAfterEach = NO;
  invokedAfterAll = NO;
}

- (void)testUnexpectedExceptionHandling {
  shouldRaiseException = YES;

  XCTestSuiteRun *result = RunSpec(_UnexpectedExceptionTestSpec);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertEqual([result unexpectedExceptionCount], 1);
  SPTAssertFalse([result hasSucceeded]);

  shouldRaiseException = NO;

  SPTAssertTrue(invokedAfterEach);
  SPTAssertTrue(invokedAfterAll);

  invokedAfterAll = NO;
}

@end
