#import "TestHelper.h"

XCTestSuiteRun *RunSpecClass(Class testClass) {
  __block XCTestSuiteRun *result;

  XCTestObservationCenter *observationCenter = [XCTestObservationCenter sharedObservationCenter];
  [observationCenter _suspendObservationForBlock:^{
    result = (id)[(XCTestSuite *)[XCTestSuite testSuiteForTestCaseClass:testClass] run];
  }];

  return result;
}