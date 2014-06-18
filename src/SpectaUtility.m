#import "SpectaUtility.h"
#import "SPTXCTestCase.h"
#import <objc/runtime.h>

NSString * const SPTCurrentSpecKey = @"SPTCurrentSpec";
NSString * const SPTCurrentTestCaseKey = @"SPTCurrentTestCase";

BOOL SPTIsSpecClass(Class aClass) {
  Class superclass = class_getSuperclass(aClass);
  while (superclass != Nil) {
    if (superclass == [SPTXCTestCase class]) {
      return YES;
    } else {
      superclass = class_getSuperclass(superclass);
    }
  }
  return NO;
}