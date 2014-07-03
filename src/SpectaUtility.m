#import "SpectaUtility.h"
#import "SPTTestCase.h"
#import <objc/runtime.h>

NSString * const SPTCurrentTestSuiteKey = @"SPTCurrentTestSuite";
NSString * const SPTCurrentTestCaseKey = @"SPTCurrentTestCase";

BOOL spt_isTestCaseClass(Class aClass) {
  Class superclass = class_getSuperclass(aClass);
  while (superclass != Nil) {
    if (superclass == [SPTTestCase class]) {
      return YES;
    } else {
      superclass = class_getSuperclass(superclass);
    }
  }
  return NO;
}