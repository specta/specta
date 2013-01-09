#import "Specta.h"
#import "SpectaTypes.h"
#import "SpectaUtility.h"

@implementation Specta
@end

#define SPT_currentSpec  [[[NSThread currentThread] threadDictionary] objectForKey:@"SPT_currentSpec"]
#define SPT_groupStack   [SPT_currentSpec groupStack]
#define SPT_currentGroup [SPT_currentSpec currentGroup]
#define SPT_returnUnlessBlockOrNil(block) if((block) && !SPT_isBlock((block))) return;

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

void example(NSString *name, id block) {
  SPT_returnUnlessBlockOrNil(block);
  [SPT_currentGroup addExampleWithName:name block:block];
}

void it(NSString *name, id block) {
  example(name, block);
}

void specify(NSString *name, id block) {
  example(name, block);
}

void SPT_pending(NSString *name, ...) {
  example(name, nil);
}

void beforeAll(id block) {
  SPT_returnUnlessBlockOrNil(block);
  [SPT_currentGroup addBeforeAllBlock:block];
}

void afterAll(id block) {
  SPT_returnUnlessBlockOrNil(block);
  [SPT_currentGroup addAfterAllBlock:block];
}

void beforeEach(id block) {
  SPT_returnUnlessBlockOrNil(block);
  [SPT_currentGroup addBeforeEachBlock:block];
}

void afterEach(id block) {
  SPT_returnUnlessBlockOrNil(block);
  [SPT_currentGroup addAfterEachBlock:block];
}

void before(id block) {
  beforeEach(block);
}

void after(id block) {
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
  } else {
    SPTSenTestCase *currentTestCase = [[[NSThread currentThread] threadDictionary] objectForKey:@"SPT_currentTestCase"];
    if(currentTestCase) {
      SPTSpec *spec = [[currentTestCase class] SPT_spec];
      NSException *exception = [NSException failureInFile:spec.fileName atLine:(int)spec.lineNumber withDescription:@"itShouldBehaveLike should not be invoked inside an example block!"];
      [currentTestCase failWithException: exception];
    }
  }
}

void itBehavesLike(NSString *name, id dictionaryOrBlock) {
  itShouldBehaveLike(name, dictionaryOrBlock);
}

void setAsyncSpecTimeout(NSTimeInterval timeout) {
  [SPTExampleGroup setAsyncSpecTimeout:timeout];
}
