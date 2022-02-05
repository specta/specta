#import "SPTSharedExampleGroups.h"
#import "SPTExampleGroup.h"
#import "SPTSpec.h"
#import "SpectaUtility.h"
#import <objc/runtime.h>

static const NSMutableDictionary *globalSharedExampleGroups = nil;

@implementation SPTSharedExampleGroups

+ (void)initialize {
  Class SPTSharedExampleGroupsClass = [SPTSharedExampleGroups class];
  if ([self class] == SPTSharedExampleGroupsClass) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      globalSharedExampleGroups = [[NSMutableDictionary alloc] init];
    });
  }
}

+ (void)addSharedExampleGroupWithName:(NSString *)name block:(SPTDictionaryBlock)block exampleGroup:(SPTExampleGroup *)exampleGroup {
  (exampleGroup == nil ? globalSharedExampleGroups : exampleGroup.sharedExamples)[name] = [block copy];
}

+ (SPTDictionaryBlock)sharedExampleGroupWithName:(NSString *)name exampleGroup:(SPTExampleGroup *)exampleGroup {
  SPTDictionaryBlock sharedExampleGroup = nil;
  while (exampleGroup != nil) {
    if ((sharedExampleGroup = exampleGroup.sharedExamples[name])) {
      return sharedExampleGroup;
    }
    exampleGroup = exampleGroup.parent;
  }
  return globalSharedExampleGroups[name];
}

- (void)sharedExampleGroups {}

- (void)spt_handleException:(NSException *)exception {
  [SPTCurrentSpec spt_handleException:exception];
}

- (void)recordIssue:(XCTIssue *)issue {
    [SPTCurrentSpec recordIssue:issue];
}

- (void)_recordUnexpectedFailureWithDescription:(NSString *)description exception:(NSException *)exception {
  [SPTCurrentSpec _recordUnexpectedFailureWithDescription:description exception:exception];
}

- (_XCTestCaseImplementation *)internalImplementation {
  return [SPTCurrentSpec internalImplementation];
}

@end
