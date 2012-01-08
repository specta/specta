#import <SenTestingKit/SenTestingKit.h>
#define SPT_SHORTHAND
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#define RunSpec(TestClass) RunSpecClass([TestClass class])

SenTestRun *RunSpecClass(Class testClass);
