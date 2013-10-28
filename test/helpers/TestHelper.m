#import "TestHelper.h"
#import "XCTestLog+SpectaTest.h"

XCTestSuiteRun *RunSpecClass(Class testClass) {
  XCTestLog *testLog = [XCTestLog spt_sharedTestLog];
  [testLog stopObserving];
  XCTestSuiteRun *result = (id)[(XCTestSuite *)[XCTestSuite testSuiteForTestCaseClass:testClass] run];
  [testLog startObserving];
  return result;
}