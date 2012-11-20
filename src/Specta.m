#import "Specta.h"
#import "SpectaTypes.h"
#import "SPTBlockTrampoline.h"

@implementation Specta
@end

#define SPT_currentSpec  [[[NSThread currentThread] threadDictionary] objectForKey:@"SPT_currentSpec"]
#define SPT_groupStack   [SPT_currentSpec groupStack]
#define SPT_currentGroup [SPT_currentSpec currentGroup]

void describe(NSString *name, void (^block)()) {
  if(block) {
    [SPT_groupStack addObject:[SPT_currentGroup addExampleGroupWithName:name]];
    block();
    [SPT_groupStack removeLastObject];
  } else {
    example(name, nil);
  }
}

void context(NSString *name, void (^block)()) {
  describe(name, block);
}

void example(NSString *name, void (^block)()) {
  [SPT_currentGroup addExampleWithName:name block:block];
}

void it(NSString *name, void (^block)()) {
  example(name, block);
}

void specify(NSString *name, void (^block)()) {
  example(name, block);
}

void _pending(NSString *name, ...) {
  example(name, nil);
}

void beforeAll(void (^block)()) {
  [SPT_currentGroup addBeforeAllBlock:block];
}

void afterAll(void (^block)()) {
  [SPT_currentGroup addAfterAllBlock:block];
}

void beforeEach(void (^block)()) {
  [SPT_currentGroup addBeforeEachBlock:block];
}

void afterEach(void (^block)()) {
  [SPT_currentGroup addAfterEachBlock:block];
}

void before(void (^block)()) {
  beforeEach(block);
}

void after(void (^block)()) {
  afterEach(block);
}

void sharedExamplesFor(NSString *name, id block) {
  [SPTSharedExampleGroups addSharedExampleGroupWithName:name block:block exampleGroup:SPT_currentGroup];
}

void sharedExamples(NSString *name, id block) {
  sharedExamplesFor(name, block);
}

void itShouldBehaveLike(NSString *name, id arg, ...) {
  id block = [SPTSharedExampleGroups sharedExampleGroupWithName:name exampleGroup:SPT_currentGroup];

  NSMutableArray *objects = [NSMutableArray array];
  va_list args;
  va_start(args, arg);
  for(id currentObject = arg; currentObject != nil; currentObject = va_arg(args, id)) {
    [objects addObject:currentObject];
  }
  va_end(args);

  if(block) {
    [SPTBlockTrampoline invokeBlock:block withArguments:objects];
  }
}
