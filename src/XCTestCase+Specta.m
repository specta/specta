#import <objc/runtime.h>
#import "XCTestCase+Specta.h"
#import "SPTTestCase.h"
#import "SPTExample.h"
#import "XCTest+Private.h"

#ifdef _SPT_XCODE6
  #define spt_allSubclasses allSubclasses
#else
  #define spt_allSubclasses xct_allSubclasses
#endif

@interface XCTestCase (xct_allSubclasses)

- (NSArray *)spt_allSubclasses;

@end

@implementation XCTestCase (Specta)

+ (void)load {
  Method allSubclasses = class_getClassMethod(self, @selector(spt_allSubclasses));
  Method allSubclasses_swizzle = class_getClassMethod(self , @selector(spt_allSubclasses_swizzle));
  method_exchangeImplementations(allSubclasses, allSubclasses_swizzle);
}

+ (NSArray *)spt_allSubclasses_swizzle {
  NSMutableArray *subclasses = [[self spt_allSubclasses_swizzle] mutableCopy]; // call original
  [subclasses removeObject:[SPTTestCase class]];
  return subclasses;
}

- (void)spt_handleException:(NSException *)exception {
  NSString *description = [exception reason];
  if ([exception userInfo]) {
    id line = [exception userInfo][@"line"];
    id file = [exception userInfo][@"file"];
    if ([line isKindOfClass:[NSNumber class]] && [file isKindOfClass:[NSString class]]) {
      [self recordFailureWithDescription:description inFile:file atLine:[line unsignedIntegerValue] expected:YES];
      return;
    }
  }
  [self _recordUnexpectedFailureWithDescription:description exception:exception];
}

@end