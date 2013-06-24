#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#define RunSpec(TestClass) RunSpecClass([TestClass class])

SenTestSuiteRun *RunSpecClass(Class testClass);
