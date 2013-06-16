#import "SenTestRun+Specta.h"

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

@end
