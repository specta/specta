#import "SPTTestCase.h"
#import "SPTExampleGroup.h"
#import <objc/runtime.h>

@interface SPTTestCase ()

+ (void)compileSpec;

@end

@implementation SPTTestCase

+ (void)initialize {
  SPTExampleGroup *rootGroup = [[SPTExampleGroup alloc] init];
  rootGroup.root = rootGroup;
  NSMutableArray *groupStack = [NSMutableArray arrayWithObject:rootGroup];
  objc_setAssociatedObject(self, "SPT_rootGroup", rootGroup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  objc_setAssociatedObject(self, "SPT_groupStack", groupStack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [rootGroup release];
  SPTTestCase *instance = [[self alloc] init];
  [instance defineSpec];
  [instance release];
  [self compileSpec];
  [super initialize];
}

- (void)defineSpec {}

+ (SPTExampleGroup *)rootGroup {
  return objc_getAssociatedObject(self, "SPT_rootGroup");
}

+ (NSMutableArray *)groupStack {
  return objc_getAssociatedObject(self, "SPT_groupStack");
}

+ (SPTExampleGroup *)currentGroup {
  return [[self groupStack] lastObject];
}


+ (void)compileSpec {
  [[self rootGroup] compileExamples:self index:0];
}

@end

