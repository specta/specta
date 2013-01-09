#import "SPTSharedExampleGroups.h"
#import "SPTExampleGroup.h"
#import <objc/runtime.h>

NSMutableDictionary *globalSharedExampleGroups = nil;
BOOL initialized = NO;

@implementation SPTSharedExampleGroups

+ (void)initialize {
  @synchronized(self) {
    Class SPTSharedExampleGroupsClass = [SPTSharedExampleGroups class];
    if([self class] == SPTSharedExampleGroupsClass) {
      if(!initialized) {
        initialized = YES;
        globalSharedExampleGroups = [[NSMutableDictionary alloc] init];

        Class *classes = NULL;
        int numClasses = objc_getClassList(NULL, 0);

        if(numClasses > 0) {
          classes = malloc(sizeof(Class) * numClasses);
          numClasses = objc_getClassList(classes, numClasses);

          Class klass, superClass;
          for(uint i = 0; i < numClasses; i++) {
            klass = classes[i];
            superClass = class_getSuperclass(klass);
            if(superClass == SPTSharedExampleGroupsClass) {
              [klass defineSharedExampleGroups];
            }
          }

          free(classes);
        }
      }
    }
  }
}

+ (void)addSharedExampleGroupWithName:(NSString *)name block:(SPTDictionaryBlock)block exampleGroup:(SPTExampleGroup *)exampleGroup {
  [(exampleGroup == nil ? globalSharedExampleGroups : exampleGroup.sharedExamples) setObject:[[block copy] autorelease] forKey:name];
}

+ (SPTDictionaryBlock)sharedExampleGroupWithName:(NSString *)name exampleGroup:(SPTExampleGroup *)exampleGroup {
  SPTDictionaryBlock sharedExampleGroup = nil;
  while(exampleGroup != nil) {
    if((sharedExampleGroup = [exampleGroup.sharedExamples objectForKey:name])) {
      return sharedExampleGroup;
    }
    exampleGroup = exampleGroup.parent;
  }
  return [globalSharedExampleGroups objectForKey:name];
}

+ (void)defineSharedExampleGroups {}

@end
