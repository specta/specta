#import "TestHelper.h"

SenTestSuiteRun *RunSpecClass(Class testClass) {
  [SenTestObserver suspendObservation];
  SenTestSuiteRun *result = (id)[(SenTestSuite *)[SenTestSuite testSuiteForTestCaseClass:testClass] run];
  [SenTestObserver resumeObservation];
  return result;
}
