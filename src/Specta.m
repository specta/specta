#import "Specta.h"
#import "SpectaTypes.h"

@implementation Specta
@end

#define SPT_currentSpec  [[[NSThread currentThread] threadDictionary] objectForKey:@"SPT_currentSpec"]
#define SPT_groupStack   [SPT_currentSpec groupStack]
#define SPT_currentGroup [SPT_currentSpec currentGroup]

#define SPT_isBlock(obj) [(obj) isKindOfClass:NSClassFromString(@"NSBlock")]

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

void sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data)) {
  [SPTSharedExampleGroups addSharedExampleGroupWithName:name block:block exampleGroup:SPT_currentGroup];
}

void sharedExamples(NSString *name, void (^block)(NSDictionary *data)) {
  sharedExamplesFor(name, block);
}

void itShouldBehaveLike(NSString *name, id dictionaryOrBlock) {
  SPTDictionaryBlock block = [SPTSharedExampleGroups sharedExampleGroupWithName:name exampleGroup:SPT_currentGroup];
  if(block) {
    if(SPT_isBlock(dictionaryOrBlock)) {
      id (^dataBlock)(void) = [[dictionaryOrBlock copy] autorelease];

      describe(name, ^{
        __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];

        beforeEach(^{
          NSDictionary *blockData = dataBlock();
          [dataDict removeAllObjects];
          [dataDict addEntriesFromDictionary:blockData];
        });

        block(dataDict);
      });
    } else {
      NSDictionary *data = dictionaryOrBlock;

      describe(name, ^{
        block(data);
      });
    }
  }
}

void itBehavesLike(NSString *name, id dictionaryOrBlock) {
  itShouldBehaveLike(name, dictionaryOrBlock);
}
