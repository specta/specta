#import "SPTDefaultReporter.h"
#import "SPTSenTestCase.h"
#import "SenTestRun+Specta.h"
#import "SenTestCase+Specta.h"
#import "SpectaUtility.h"
#import <objc/runtime.h>

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
    [self printSessionDetails:suiteRun];
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

- (void)printSessionDetails:(SenTestSuiteRun *)suiteRun
{
  [self printXCodeIntegrationOutputForSession:suiteRun];
  if ([suiteRun hasSucceeded] == NO)
  {
    [self printSessionFailures:suiteRun];
  }
  [self printSessionResults:suiteRun];
}

- (void)printSessionFailures:(SenTestSuiteRun *)suiteRun
{
  [self printSectionHeader:@"Failures"];
  
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
  
  [self printLineWithFormat:@"%lu tests; %lu failures; %lu exceptions",
                            (unsigned long)[suiteRun testCaseCount],
                            (unsigned long)[suiteRun failureCount],
                            (unsigned long)[suiteRun unexpectedExceptionCount]];
}

- (void)printSummaryForTestCaseClass:(Class)testCaseClass
                        testCaseRuns:(NSArray *)testCaseRuns
{
  NSUInteger numberOfFailures = 0;
  NSUInteger numberOfExceptions = 0;
  
  for (SenTestCaseRun * testRun in testCaseRuns)
  {
    numberOfFailures += testRun.failureCount;
    numberOfExceptions += testRun.unexpectedExceptionCount;
  }
  
  if (numberOfFailures + numberOfExceptions > 0)
  {
    NSString * failureLabel = [[self class] pluralizeString:@"failure"
                                               pluralString:@"failures"
                                                      count:numberOfFailures];
    
    NSString * exceptionLabel = [[self class] pluralizeString:@"exception"
                                                 pluralString:@"exceptions"
                                                        count:numberOfExceptions];
    
    [self printLineWithFormat:@"+ %s (%lu %@, %lu %@)\n",
                              class_getName(testCaseClass),
                              (unsigned long)numberOfFailures,
                              failureLabel,
                              (unsigned long)numberOfExceptions,
                              exceptionLabel];

    for (SenTestCaseRun * testRun in testCaseRuns)
    {
      for (NSException * failure in testRun.exceptions)
      {
        if ([failure.name isEqualToString:SenTestFailureException])
        {
          [self printLineWithFormat:@"  - %@ (FAILURE)\n    %@:%@\n\n    %@\n",
                                    [(SenTestCase *)[testRun test] SPT_title],
                                    [failure filename],
                                    [failure lineNumber],
                                    [failure reason]];
        }
        else
        {
          [self printLineWithFormat:@"  - %@ (%@)\n    %@\n\n    %@\n",
                                    [(SenTestCase *)[testRun test] SPT_title],
                                    [failure name],
                                    [[testRun.test class] SPT_testCasePathname],
                                    [failure reason]];
        }
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
        
        if ([filename isEqualToString:@"Unknown.m"])
        {
          filename = [[testRun.test class] SPT_testCasePathname];
          lineNumber = @(0);
        }
        
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
