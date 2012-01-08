#import "TestHelper.h"

SenTestRun *RunSpecClass(Class testClass) {
  [SenTestObserver suspendObservation];
  SenTestRun *result = [(SenTestSuite *)[SenTestSuite testSuiteForTestCaseClass:testClass] run];
  [SenTestObserver resumeObservation];
  return result;
}
