#import "TestHelper.h"

XCTestSuiteRun *RunSpecClass(Class testClass) {
  __block XCTestSuiteRun *result;

#ifdef _SPT_XCODE6
  XCTestObservationCenter *observationCenter = [XCTestObservationCenter sharedObservationCenter];
  [observationCenter _suspendObservationForBlock:^{
    result = (id)[(XCTestSuite *)[XCTestSuite testSuiteForTestCaseClass:testClass] run];
  }];
#else
//  [[SPTReporter sharedReporter] spt_pauseObservationInBlock:^{
//    result = (id)[(XCTestSuite *)[XCTestSuite testSuiteForTestCaseClass:testClass] run];
//  }];
#endif

  return result;
}