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
    if(shouldRaiseException) {
      raiseException();
    }
  });
});

SpecEnd

@interface UnexpectedExceptionTest : SenTestCase; @end
@implementation UnexpectedExceptionTest

- (void)setUp
{
  invokedAfterEach = NO;
  invokedAfterAll = NO;
}

- (void)testUnexpectedExceptionHandling {
  shouldRaiseException = YES;
  
  SenTestSuiteRun *result = RunSpec(_UnexpectedExceptionTestSpec);
  expect([result failureCount]).toEqual(0);
  expect([result unexpectedExceptionCount]).toEqual(1);
  expect([result hasSucceeded]).toEqual(NO);

  NSException *exception = [[[[result testRuns] lastObject] exceptions] lastObject];
  NSString *reason = [exception reason];
  expect(reason).toContain(@"MyException: Oh Noes!");
  if([NSException instancesRespondToSelector:@selector(callStackSymbols)]) {
    expect(reason).toContain(@"Call Stack:");
    expect(reason).toContain(@"raiseException");
    expect(reason).toContain(@"UnexpectedExceptionTest");
  }
  expect([exception filename]).toContain(@"UnexpectedExceptionTest.m");
  
  expect(invokedAfterEach).toBeTruthy();
  expect(invokedAfterAll).toBeTruthy();
  
  invokedAfterAll = NO;
}

@end
