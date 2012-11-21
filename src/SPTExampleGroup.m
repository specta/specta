#import "SPTExampleGroup.h"
#import "SPTExample.h"

@interface SPTExampleGroup ()

- (void)incrementExampleCount;
- (void)resetRanExampleCountIfNeeded;
- (void)incrementRanExampleCount;
- (void)runBeforeHooks;
- (void)runAfterHooks;

@end

@implementation SPTExampleGroup

@synthesize
  name=_name
, root=_root
, parent=_parent
, children=_children
, beforeAllArray=_beforeAllArray
, afterAllArray=_afterAllArray
, beforeEachArray=_beforeEachArray
, afterEachArray=_afterEachArray
, sharedExamples=_sharedExamples
, exampleCount=_exampleCount
, ranExampleCount=_ranExampleCount
;

- (void)dealloc {
  self.name = nil;
  self.root = nil;
  self.parent = nil;
  self.children = nil;
  self.beforeAllArray = nil;
  self.afterAllArray = nil;
  self.beforeEachArray = nil;
  self.afterEachArray = nil;
  self.sharedExamples = nil;
  [super dealloc];
}

- (id)init {
  self = [super init];
  if(self) {
    self.name = nil;
    self.root = nil;
    self.parent = nil;
    self.children = [NSMutableArray array];
    self.beforeAllArray = [NSMutableArray array];
    self.afterAllArray = [NSMutableArray array];
    self.beforeEachArray = [NSMutableArray array];
    self.afterEachArray = [NSMutableArray array];
    self.sharedExamples = [NSMutableDictionary dictionary];
    self.exampleCount = 0;
    self.ranExampleCount = 0;
  }
  return self;
}

- (id)initWithName:(NSString *)name parent:(SPTExampleGroup *)parent root:(SPTExampleGroup *)root {
  self = [self init];
  if(self) {
    self.name = name;
    self.parent = parent;
    self.root = root;
  }
  return self;
}

- (SPTExampleGroup *)addExampleGroupWithName:(NSString *)name {
  SPTExampleGroup *group = [[SPTExampleGroup alloc] initWithName:name parent:self root:self.root];
  [self.children addObject:group];
  return [group autorelease];
}

- (SPTExample *)addExampleWithName:(NSString *)name block:(SPTVoidBlock)block {
  SPTExample *example;
  @synchronized(self) {
    example = [[SPTExample alloc] initWithName:name block:block];
    if(!block) {
      example.pending = YES;
    }
    [self.children addObject:example];
    [self incrementExampleCount];
  }
  return [example autorelease];
}

- (void)incrementExampleCount {
  SPTExampleGroup *group = self;
  while(group != nil) {
    group.exampleCount ++;
    group = group.parent;
  }
}

- (void)resetRanExampleCountIfNeeded {
  SPTExampleGroup *group = self;
  while(group != nil) {
    if(group.ranExampleCount >= group.exampleCount) {
      group.ranExampleCount = 0;
    }
    group = group.parent;
  }
}

- (void)incrementRanExampleCount {
  SPTExampleGroup *group = self;
  while(group != nil) {
    group.ranExampleCount ++;
    group = group.parent;
  }
}

- (void)addBeforeAllBlock:(SPTVoidBlock)block {
  if(!block) return;
  [self.beforeAllArray addObject:[[block copy] autorelease]];
}

- (void)addAfterAllBlock:(SPTVoidBlock)block {
  if(!block) return;
  [self.afterAllArray addObject:[[block copy] autorelease]];
}

- (void)addBeforeEachBlock:(SPTVoidBlock)block {
  if(!block) return;
  [self.beforeEachArray addObject:[[block copy] autorelease]];
}

- (void)addAfterEachBlock:(SPTVoidBlock)block {
  if(!block) return;
  [self.afterEachArray addObject:[[block copy] autorelease]];
}

- (void)runBeforeHooks {
  NSMutableArray *groups = [NSMutableArray array];
  SPTExampleGroup *group = self;
  while(group != nil) {
    [groups insertObject:group atIndex:0];
    group = group.parent;
  }
  // run beforeAll hooks
  for(group in groups) {
    if(group.ranExampleCount == 0) {
      for(SPTVoidBlock beforeAllBlock in group.beforeAllArray) {
        beforeAllBlock();
      }
    }
  }
  // run beforeEach hooks
  for(group in groups) {
    for(SPTVoidBlock beforeEachBlock in group.beforeEachArray) {
      beforeEachBlock();
    }
  }
}

- (void)runAfterHooks {
  NSMutableArray *groups = [NSMutableArray array];
  SPTExampleGroup *group = self;
  while(group != nil) {
    [groups addObject:group];
    group = group.parent;
  }
  // run afterEach hooks
  for(group in groups) {
    for(SPTVoidBlock afterEachBlock in group.afterEachArray) {
      afterEachBlock();
    }
  }
  // run afterAll hooks
  for(group in groups) {
    if(group.ranExampleCount == group.exampleCount) {
      for(SPTVoidBlock afterAllBlock in group.afterAllArray) {
        afterAllBlock();
      }
    }
  }
}

- (NSArray *)compileExamplesWithNameStack:(NSArray *)nameStack {
  NSArray *compiled = [NSArray array];
  for(id child in self.children) {
    if([child isKindOfClass:[SPTExampleGroup class]]) {
      SPTExampleGroup *group = child;
      NSArray *newNameStack = [nameStack arrayByAddingObject:group.name];
      compiled = [compiled arrayByAddingObjectsFromArray:[group compileExamplesWithNameStack:newNameStack]];
    } else if([child isKindOfClass:[SPTExample class]]) {
      SPTExample *example = child;
      NSArray *newNameStack = [nameStack arrayByAddingObject:example.name];
      NSString *compiledName = [newNameStack componentsJoinedByString:@" "];
      SPTVoidBlock compiledBlock = example.pending ? nil : ^{
        @synchronized(self.root) {
          [self resetRanExampleCountIfNeeded];
          [self runBeforeHooks];
        }
        example.block();
        @synchronized(self.root) {
          [self incrementRanExampleCount];
          [self runAfterHooks];
        }
      };
      SPTExample *compiledExample = [[SPTExample alloc] initWithName:compiledName block:compiledBlock];
      compiledExample.pending = example.pending;
      compiled = [compiled arrayByAddingObject:compiledExample];
      [compiledExample release];
    }
  }
  return compiled;
}

@end
