#import "SenTestRun+Specta.h"
#import "SPTSenTestCase.h"
#import "SPTExample.h"

@implementation SenTestRun (Specta)

- (void)SPT_visitTestCaseRunsWithBlock:(void(^)(SenTestCaseRun * testRun))block
{
  if (block == nil) return;
  
  if ([self isKindOfClass:[SenTestSuiteRun class]])
  {
    NSArray * testRuns = ((SenTestSuiteRun *)self).testRuns;
    if (testRuns != nil)
    {
      for (SenTestRun * testRun in testRuns)
      {
        [testRun SPT_visitTestCaseRunsWithBlock:block];
      }
    }
  }
  else if ([self isKindOfClass:[SenTestCaseRun class]])
  {
    block((SenTestCaseRun *)self);
  }
}

// ===== PENDING TEST CASES ============================================================================================
#pragma mark - Pending Test Cases

- (NSUInteger)pendingTestCaseCount
{
  NSUInteger pendingTestCaseCount = 0;
  
  if ([self isKindOfClass:[SenTestSuiteRun class]])
  {
    for (SenTestRun * testRun in [(SenTestSuiteRun *)self testRuns])
    {
      pendingTestCaseCount += [testRun pendingTestCaseCount];
    }
  }
  else if ([[self test] isKindOfClass:[SPTSenTestCase class]])
  {
    SPTSenTestCase * testCase = (SPTSenTestCase *)[self test];
    if (testCase != nil && [testCase SPT_isPending])
    {
      pendingTestCaseCount++;
    }
  }

  return pendingTestCaseCount;
}

// ===== SKIPPED TEST CASES ============================================================================================
#pragma mark - Skipped Test Cases

- (NSUInteger)skippedTestCaseCount
{
  NSUInteger skippedTestCaseCount = 0;
  
  if ([self isKindOfClass:[SenTestSuiteRun class]])
  {
    for (SenTestRun * testRun in [(SenTestSuiteRun *)self testRuns])
    {
      skippedTestCaseCount += [testRun skippedTestCaseCount];
    }
  }
  else if ([[self test] isKindOfClass:[SPTSenTestCase class]])
  {
    SPTSenTestCase * testCase = (SPTSenTestCase *)[self test];
    if (testCase.SPT_skipped)
    {
      skippedTestCaseCount++;
    }
  }
  
  return skippedTestCaseCount;
}

@end
