#import "SpectaUtility.h"
#import "SPTSpec.h"
#import <objc/runtime.h>

NSString * const SPTCurrentTestSuiteKey = @"SPTCurrentTestSuite";
NSString * const SPTCurrentSpecKey = @"SPTCurrentSpec";

BOOL spt_isTestCaseClass(Class aClass) {
  Class superclass = class_getSuperclass(aClass);
  while (superclass != Nil) {
    if (superclass == [SPTSpec class]) {
      return YES;
    } else {
      superclass = class_getSuperclass(superclass);
    }
  }
  return NO;
}