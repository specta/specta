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
    SPTExample * example = [(SPTSenTestCase *)[self test] SPT_getCurrentExample];
    if (example == nil || example.pending)
    {
      return 1;
    }
  }

  return pendingTestCaseCount;
}

@end
