#import "XCTestCase+Specta.h"
#import "SPTXCTestCase.h"
#import "SPTExample.h"
#import <objc/runtime.h>

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
  [subclasses removeObject:[SPTXCTestCase class]];
  return subclasses;
}

@end