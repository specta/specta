#import "SPTDefaultReporter.h"
#import "SPTSenTestCase.h"
#import "SenTestRun+Specta.h"
#import "SenTestCase+Specta.h"
#import "SpectaUtility.h"
#import <objc/runtime.h>

@interface SPTDefaultReporter ()

+ (NSString *)conciseRunInfoWithNumberOfTests:(NSUInteger)numberOfTests
                         numberOfSkippedTests:(NSUInteger)numberOfSkippedTests
                             numberOfFailures:(NSUInteger)numberOfFailures
                           numberOfExceptions:(NSUInteger)numberOfExceptions
                         numberOfPendingTests:(NSUInteger)numberOfPendingTests;
+ (NSString *)pluralizeString:(NSString *)singularString
                 pluralString:(NSString *)pluralString
                        count:(NSInteger)count;

- (void)printSectionHeader:(NSString *)header;
- (void)printSessionSections:(SenTestSuiteRun *)suiteRun;
- (void)printSessionDetails:(SenTestSuiteRun *)suiteRun;
- (void)printSessionResults:(SenTestSuiteRun *)suiteRn;
- (void)printSummaryForTestCaseClass:(Class)testCaseClass
                        testCaseRuns:(NSArray *)testCaseRuns;
- (void)printXCodeIntegrationOutputForSession:(SenTestRun *)sessionRun;

@end

@implementation SPTDefaultReporter

// ===== SPTReporter ===================================================================================================
#pragma mark - SPTReporter

- (void)testSuiteDidBegin:(SenTestSuiteRun *)suiteRun
{
  if ([self.runStack count] == 0)
  {
    SenTestSuite * testSuite = (SenTestSuite *)[suiteRun test];
    
    [self printLineWithFormat:@"Running %lu tests:",
                              (unsigned long)[testSuite testCaseCount]];
    [self printLine];
  }
  
  [super testSuiteDidBegin:suiteRun];
}

- (void)testSuiteDidEnd:(SenTestSuiteRun *)suiteRun
{
  [super testSuiteDidEnd:suiteRun];
  
  if ([self.runStack count] == 0)
  {
    [self printLine];
    [self printLine];
    [self printSessionSections:suiteRun];
  }
}

- (void)testCaseDidEnd:(SenTestCaseRun *)testCaseRun
{
  [super testCaseDidEnd:testCaseRun];
  
  if ([testCaseRun unexpectedExceptionCount] > 0)
  {
    [self printString:@"E"];
  }
  else if ([testCaseRun failureCount] > 0)
  {
    [self printString:@"F"];
  }
  else
  {
    [self printString:@"."];
  }
}

// ===== PRINTING ======================================================================================================
#pragma mark - Printing

- (void)printSectionHeader:(NSString *)header
{
  [self printStringWithFormat:@"# ----- %@ --------------------\n\n", header];
}

- (void)printSessionSections:(SenTestSuiteRun *)suiteRun
{
  [self printXCodeIntegrationOutputForSession:suiteRun];
  if ([suiteRun hasSucceeded] == NO || [suiteRun pendingTestCaseCount] > 0)
  {
    [self printSessionDetails:suiteRun];
  }
  [self printSessionResults:suiteRun];
}

- (void)printSessionDetails:(SenTestSuiteRun *)suiteRun
{
  [self printSectionHeader:@"Details"];
  
  NSMutableArray * testCaseClassNames = [NSMutableArray array];
  NSMutableDictionary * testRunsByTestClass = [NSMutableDictionary dictionary];
  
  [suiteRun SPT_visitTestCaseRunsWithBlock:^(SenTestCaseRun *testRun) {
    
    NSString * testCaseClassName = NSStringFromClass([[testRun test] class]);
    if ([testCaseClassNames containsObject:testCaseClassName] == NO)
    {
      [testCaseClassNames addObject:testCaseClassName];
    }
    
    NSMutableArray * testRuns = [testRunsByTestClass objectForKey:testCaseClassName];
    if (testRuns == nil)
    {
      testRuns = [NSMutableArray array];
      [testRunsByTestClass setObject:testRuns
                              forKey:testCaseClassName];
    }
    
    [testRuns addObject:testRun];
    
  }];
  
  for (NSString * testCaseClassName in testCaseClassNames)
  {
    Class testCaseClass = NSClassFromString(testCaseClassName);
    NSArray * testCaseRuns = [testRunsByTestClass objectForKey:testCaseClassName];
    
    [self printSummaryForTestCaseClass:testCaseClass
                          testCaseRuns:testCaseRuns];
  }
}

- (void)printSessionResults:(SenTestSuiteRun *)suiteRun
{
  [self printSectionHeader:@"Results"];
  
  [self printLineWithFormat:@"Session completed in %0.3f seconds",
                            suiteRun.totalDuration];

  NSString * runInfo = [[self class] conciseRunInfoWithNumberOfTests:[suiteRun testCaseCount]
                                                numberOfSkippedTests:[suiteRun skippedTestCaseCount]
                                                    numberOfFailures:[suiteRun failureCount]
                                                  numberOfExceptions:[suiteRun unexpectedExceptionCount]
                                                numberOfPendingTests:[suiteRun pendingTestCaseCount]];
    
  [self printLine:runInfo];
}

+ (NSString *)conciseRunInfoWithNumberOfTests:(NSUInteger)numberOfTests
                         numberOfSkippedTests:(NSUInteger)numberOfSkippedTests
                             numberOfFailures:(NSUInteger)numberOfFailures
                           numberOfExceptions:(NSUInteger)numberOfExceptions
                         numberOfPendingTests:(NSUInteger)numberOfPendingTests
{
  NSString * testLabel = [[self class] pluralizeString:@"test"
                                          pluralString:@"tests"
                                                 count:numberOfTests];
  
  NSString * failureLabel = [[self class] pluralizeString:@"failure"
                                             pluralString:@"failures"
                                                    count:numberOfFailures];
  
  NSString * exceptionLabel = [[self class] pluralizeString:@"exception"
                                               pluralString:@"exceptions"
                                                      count:numberOfExceptions];
  
  return [NSString stringWithFormat:@"%lu %@; %lu skipped; %lu %@; %lu %@; %lu pending",
                                   (unsigned long)numberOfTests,
                                   testLabel,
                                   (unsigned long)numberOfSkippedTests,
                                   (unsigned long)numberOfFailures,
                                   failureLabel,
                                   (unsigned long)numberOfExceptions,
                                   exceptionLabel,
                                   (unsigned long)numberOfPendingTests];
}

- (void)printSummaryForTestCaseClass:(Class)testCaseClass
                        testCaseRuns:(NSArray *)testCaseRuns
{
  NSUInteger numberOfTests = 0;
  NSUInteger numberOfSkippedTests = 0;
  NSUInteger numberOfFailures = 0;
  NSUInteger numberOfExceptions = 0;
  NSUInteger numberOfPendingTests = 0;
  
  for (SenTestCaseRun * testRun in testCaseRuns)
  {
    numberOfTests += testRun.testCaseCount;
    numberOfSkippedTests += testRun.skippedTestCaseCount;
    numberOfFailures += testRun.failureCount;
    numberOfExceptions += testRun.unexpectedExceptionCount;
    numberOfPendingTests += [testRun pendingTestCaseCount];
  }
  
  if (numberOfFailures + numberOfExceptions + numberOfPendingTests > 0)
  {
    NSString * runInfo = [[self class] conciseRunInfoWithNumberOfTests:numberOfTests
                                                  numberOfSkippedTests:numberOfSkippedTests
                                                      numberOfFailures:numberOfFailures
                                                    numberOfExceptions:numberOfExceptions
                                                  numberOfPendingTests:numberOfPendingTests];
    
    [self printLineWithFormat:@"+ %s (%@)\n",
                              class_getName(testCaseClass),
                              runInfo];

    for (SenTestCaseRun * testRun in testCaseRuns)
    {
      if ([testRun pendingTestCaseCount] > 0)
      {
        [self printLineWithFormat:@"  - %@ (PENDING)",
                                 [(SenTestCase *)[testRun test] SPT_title]];
        [self printLine];
      }
      
      for (NSException * failure in testRun.exceptions)
      {
        if ([failure.name isEqualToString:SenTestFailureException])
        {
          [self printLineWithFormat:@"  - %@ (FAILURE)\n    %@:%@\n\n    %@",
                                    [(SenTestCase *)[testRun test] SPT_title],
                                    [failure filename],
                                    [failure lineNumber],
                                    [failure reason]];
        }
        else
        {
          [self printLineWithFormat:@"  - %@\n    %@\n\n    %@",
                                    [(SenTestCase *)[testRun test] SPT_title],
                                    [failure name],
                                    [failure reason]];
        }
        [self printLine];
      }
    }
    
    
  }
}

- (void)printXCodeIntegrationOutputForSession:(SenTestRun *)sessionRun
{
  [self printSectionHeader:@"XCode (OCUnit) Test Output"];
  
  [sessionRun SPT_visitTestCaseRunsWithBlock:^(SenTestCaseRun *testRun) {
    
    [self printLineWithFormat:@"    Test Case '%@' started.", [testRun test]];
    
    if ([testRun hasSucceeded] == NO)
    {
      for (NSException * failure in testRun.exceptions)
      {
        NSString * filename = failure.filePathInProject;
        NSNumber * lineNumber = failure.lineNumber;
                
        [self printLineWithFormat:@"\n%@:%@: error: %@ : %@\n",
                                  filename,
                                  lineNumber,
                                  [testRun test],
                                  [failure reason]];
      }
    }
    
    [self printLineWithFormat:@"    Test Case '%@' %s (%.3f seconds).",
                              [testRun test],
                              ([testRun hasSucceeded] ? "passed" : "failed"),
                              [testRun totalDuration]];
  }];
  
  [self printLine];
}

+ (NSString *)pluralizeString:(NSString *)singularString
                 pluralString:(NSString *)pluralString
                        count:(NSInteger)count
{
  if (count == 1 || count == -1)
  {
    return singularString;
  }
  else
  {
    return pluralString;
  }
}

@end
