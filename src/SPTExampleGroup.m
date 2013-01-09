#import "SPTExampleGroup.h"
#import "SPTExample.h"
#import "SPTSenTestCase.h"
#import "SPTSpec.h"
#import "SpectaUtility.h"
#import <libkern/OSAtomic.h>

static NSTimeInterval asyncSpecTimeout = 10.0;
static const char *asyncBlockSignature = NULL;

static void runExampleBlock(id block, NSString *name) {
  if(!SPT_isBlock(block)) {
    return;
  }

  if (!asyncBlockSignature) {
    asyncBlockSignature = SPT_getBlockSignature(^(void (^done)()) {});
  }

  const char *blockSignature = SPT_getBlockSignature(block);
  BOOL isAsyncBlock = strcmp(blockSignature, asyncBlockSignature) == 0;

  if(isAsyncBlock) {
    __block uint32_t complete = 0;
    ((SPTAsyncBlock)block)(^{
      OSAtomicOr32Barrier(1, &complete);
    });
    NSTimeInterval timeout = asyncSpecTimeout;
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
    while (!complete && [timeoutDate timeIntervalSinceNow] > 0) {
      [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    if (!complete) {
      NSString *message = [NSString stringWithFormat:@"\"%@\" failed to invoke done() callback before timeout (%f seconds)", name, timeout];
      SPTSenTestCase *currentTestCase = [[[NSThread currentThread] threadDictionary] objectForKey:@"SPT_currentTestCase"];
      SPTSpec *spec = [[currentTestCase class] SPT_spec];
      NSException *exception = [NSException failureInFile:spec.fileName atLine:(int)spec.lineNumber withDescription:message];
      [currentTestCase failWithException: exception];
    }
  } else {
    ((SPTVoidBlock)block)();
  }
}

@interface SPTExampleGroup ()

- (void)incrementExampleCount;
- (void)resetRanExampleCountIfNeeded;
- (void)incrementRanExampleCount;
- (void)runBeforeHooks:(NSString *)compiledName;
- (void)runAfterHooks:(NSString *)compiledName;

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

+ (void)setAsyncSpecTimeout:(NSTimeInterval)timeout {
  asyncSpecTimeout = timeout;
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

- (SPTExample *)addExampleWithName:(NSString *)name block:(id)block {
  SPTExample *example;
  @synchronized(self) {
    example = [[SPTExample alloc] initWithName:name block:block];
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

- (void)runBeforeHooks:(NSString *)compiledName {
  NSMutableArray *groups = [NSMutableArray array];
  SPTExampleGroup *group = self;
  while(group != nil) {
    [groups insertObject:group atIndex:0];
    group = group.parent;
  }
  // run beforeAll hooks
  for(group in groups) {
    if(group.ranExampleCount == 0) {
      for(id beforeAllBlock in group.beforeAllArray) {
        runExampleBlock(beforeAllBlock, [NSString stringWithFormat:@"%@ - before all block", compiledName]);
      }
    }
  }
  // run beforeEach hooks
  for(group in groups) {
    for(id beforeEachBlock in group.beforeEachArray) {
      runExampleBlock(beforeEachBlock, [NSString stringWithFormat:@"%@ - before each block", compiledName]);
    }
  }
}

- (void)runAfterHooks:(NSString *)compiledName {
  NSMutableArray *groups = [NSMutableArray array];
  SPTExampleGroup *group = self;
  while(group != nil) {
    [groups addObject:group];
    group = group.parent;
  }
  // run afterEach hooks
  for(group in groups) {
    for(id afterEachBlock in group.afterEachArray) {
      runExampleBlock(afterEachBlock, [NSString stringWithFormat:@"%@ - after each block", compiledName]);
    }
  }
  // run afterAll hooks
  for(group in groups) {
    if(group.ranExampleCount == group.exampleCount) {
      for(id afterAllBlock in group.afterAllArray) {
        runExampleBlock(afterAllBlock, [NSString stringWithFormat:@"%@ - after all block", compiledName]);
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
          [self runBeforeHooks:compiledName];
        }
        runExampleBlock(example.block, compiledName);
        @synchronized(self.root) {
          [self incrementRanExampleCount];
          [self runAfterHooks:compiledName];
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
