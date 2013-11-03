#import "TestHelper.h"
#import "SPTReporter.h"
#import "XCTestLog+Specta.h"

XCTestSuiteRun *RunSpecClass(Class testClass) {
  
  __block XCTestSuiteRun *result;
  
  [[SPTReporter sharedReporter] pauseObservationInBlock:^{
    
    result = (id)[(XCTestSuite *)[XCTestSuite testSuiteForTestCaseClass:testClass] run];
    
  }];
  
  return result;
}