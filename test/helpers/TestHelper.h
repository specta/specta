#import <SenTestingKit/SenTestingKit.h>
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#define RunSpec(TestClass) RunSpecClass([TestClass class])

SenTestSuiteRun *RunSpecClass(Class testClass);
