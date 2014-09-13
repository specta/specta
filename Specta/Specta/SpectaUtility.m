#import "SpectaUtility.h"
#import "SPTSpec.h"
#import <objc/runtime.h>

NSString * const SPTCurrentTestSuiteKey = @"SPTCurrentTestSuite";
NSString * const SPTCurrentSpecKey = @"SPTCurrentSpec";

BOOL spt_isSpecClass(Class aClass) {
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

NSString *spt_underscorize(NSString *string) {
  static NSMutableCharacterSet *invalidCharSet;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    invalidCharSet = [[NSMutableCharacterSet alloc] init];
    [invalidCharSet formUnionWithCharacterSet:[NSCharacterSet controlCharacterSet]];
    [invalidCharSet formUnionWithCharacterSet:[NSCharacterSet illegalCharacterSet]];
    [invalidCharSet formUnionWithCharacterSet:[NSCharacterSet newlineCharacterSet]];
    [invalidCharSet formUnionWithCharacterSet:[NSCharacterSet nonBaseCharacterSet]];
    [invalidCharSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    [invalidCharSet formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
  });
  NSString *stripped = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  stripped = [[stripped componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];

  NSArray *components = [stripped componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  stripped = [[components objectsAtIndexes:[components indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    return ![obj isEqualToString:@""];
  }]] componentsJoinedByString:@"_"];
  return stripped;
}

NSArray *spt_map(NSArray *array, id (^block)(id obj, NSUInteger idx)) {
  NSMutableArray *mapped = [NSMutableArray arrayWithCapacity:[array count]];
  [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [mapped addObject:block(obj, idx)];
  }];
  return mapped;
}