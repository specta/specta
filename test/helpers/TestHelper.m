#import "TestHelper.h"
#import "SPTReporter.h"
#import "XCTestObserver+Specta.h"

XCTestSuiteRun *RunSpecClass(Class testClass) {

  __block XCTestSuiteRun *result;

  [[SPTReporter sharedReporter] spt_pauseObservationInBlock:^{

    result = (id)[(XCTestSuite *)[XCTestSuite testSuiteForTestCaseClass:testClass] run];

  }];

  return result;
}