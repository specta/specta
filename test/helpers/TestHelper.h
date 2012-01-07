#import <SenTestingKit/SenTestingKit.h>
#define EXP_SHORTHAND
#import "Expecta.h"

#define RunTestSuite(TestClass) \
[(SenTestSuite *)[SenTestSuite testSuiteForTestCaseClass:[TestClass class]] run]

