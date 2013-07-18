#import "SPTReporter.h"
#import "SPTDefaultReporter.h"

@interface SPTReporter ()

+ (SPTReporter *)loadSharedReporter;

@end

@implementation SPTReporter

@synthesize
  runStack=_runStack
;

// ===== SHARED REPORTER ===============================================================================================
#pragma mark - Shared Reporter

+ (SPTReporter *)sharedReporter
{
  static SPTReporter * sharedReporter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedReporter = [[self loadSharedReporter] retain];
  });
  
  return sharedReporter;
}

+ (SPTReporter *)loadSharedReporter
{
  return [[[SPTDefaultReporter alloc] init] autorelease];
}

- (id)init
{
  self = [super init];
  if (self != nil)
  {
    self.runStack = [NSMutableArray array];
  }
  return self;
}

- (void)dealloc
{
  self.runStack = nil;
  [super dealloc];
}

// ===== SenTestObserver ===============================================================================================
#pragma mark - SenTestObserver

#define SPTSharedReporter ([SPTReporter sharedReporter])

+ (void)testSuiteDidStart:(NSNotification *) aNotification
{
  [SPTSharedReporter testSuiteDidBegin:aNotification.object];
}

+ (void)testSuiteDidStop:(NSNotification *) aNotification
{
  [SPTSharedReporter testSuiteDidEnd:aNotification.object];
}

+ (void)testCaseDidStart:(NSNotification *) aNotification
{
  [SPTSharedReporter testCaseDidBegin:aNotification.object];
}

+ (void)testCaseDidStop:(NSNotification *) aNotification
{
  [SPTSharedReporter testCaseDidEnd:aNotification.object];
}

+ (void)testCaseDidFail:(NSNotification *) aNotification
{
  [SPTSharedReporter testCaseDidFail:aNotification.object];
}

// ===== RUN STACK =====================================================================================================
#pragma mark - Run Stack

- (void)pushRunStack:(SenTestRun *)run
{
  [(NSMutableArray *)self.runStack addObject:run];
}

- (void)popRunStack:(SenTestRun *)run
{
  NSAssert(run != nil,
           @"Attempt to pop nil test run");
  
  NSAssert([self.runStack lastObject] == run,
           @"Attempt to pop test run (%@) out of order: %@",
           run,
           self.runStack);
  
  [(NSMutableArray *)self.runStack removeLastObject];
}

// ===== TEST SUITE ====================================================================================================
#pragma mark - Test Suite

- (void)testSuiteDidBegin:(SenTestSuiteRun *)suiteRun
{
  [self pushRunStack:suiteRun];
}

- (void)testSuiteDidEnd:(SenTestSuiteRun *)suiteRun
{
  [self popRunStack:suiteRun];
}

// ===== TEST CASES ====================================================================================================
#pragma mark - Test Cases

- (void)testCaseDidBegin:(SenTestCaseRun *)testCaseRun
{
  [self pushRunStack:testCaseRun];
}

- (void)testCaseDidEnd:(SenTestCaseRun *)testCaseRun
{
  [self popRunStack:testCaseRun];
}

- (void)testCaseDidFail:(SenTestCaseRun *)testCaseRun
{

}

// ===== PRINTING ======================================================================================================
#pragma mark - Printing

- (void)printString:(NSString *)string
{
  fprintf(stderr, "%s", [string UTF8String]);
}

- (void)printStringWithFormat:(NSString *)formatString, ...
{
  va_list args;
  va_start(args, formatString);
  NSString * formattedString = [[NSString alloc] initWithFormat:formatString arguments:args];
  va_end(args);
  
  [self printString:formattedString];
  [formattedString release];
}

- (void)printLine
{
  [self printString:@"\n"];
}

- (void)printLine:(NSString *)line
{
  [self printStringWithFormat:@"%@\n", line];
}

- (void)printLineWithFormat:(NSString *)formatString, ...
{
  va_list args;
  va_start(args, formatString);
  NSString * formattedString = [[NSString alloc] initWithFormat:formatString arguments:args];
  va_end(args);
  
  [self printLine:formattedString];
  
  [formattedString release];
}

@end
