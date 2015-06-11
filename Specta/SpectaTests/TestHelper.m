#import "TestHelper.h"

XCTestSuiteRun *RunSpecClass(Class testClass) {
  __block XCTestSuiteRun *result;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000 || __MAC_OS_X_VERSION_MAX_ALLOWED >= 101100
  XCTestObservationCenter *observationCenter = [XCTestObservationCenter sharedTestObservationCenter];
#else
  XCTestObservationCenter *observationCenter = [XCTestObservationCenter sharedObservationCenter];
#endif
  [observationCenter _suspendObservationForBlock:^{
    result = (id)[(XCTestSuite *)[XCTestSuite testSuiteForTestCaseClass:testClass] run];
  }];

  return result;
}
