#import "Specta.h"
#import "SpectaTypes.h"
#import "SpectaUtility.h"

@implementation Specta

+ (void)initialize {
#ifndef __clang__
  printf("<Specta> WARNING: Support for asynchronous testing (^AsyncBlock) is disabled because Specta is not compiled with the Apple LLVM Compiler (Clang, not GCC).\n\n");
#endif
}
@end

#define SPT_currentSpec  [[[NSThread currentThread] threadDictionary] objectForKey:@"SPT_currentSpec"]
#define SPT_groupStack   [SPT_currentSpec groupStack]
#define SPT_currentGroup [SPT_currentSpec currentGroup]
#define SPT_returnUnlessBlockOrNil(block) if((block) && !SPT_isBlock((block))) return;

void SPT_describe(NSString *name, BOOL focused, void (^block)())
{
  if(block) {
    [SPT_groupStack addObject:[SPT_currentGroup addExampleGroupWithName:name
                                                                focused:focused]];
    block();
    [SPT_groupStack removeLastObject];
  } else {
    SPT_example(name, focused, nil);
  }
}

void describe(NSString *name, void (^block)()) {
  SPT_describe(name, NO, block);
}

void fdescribe(NSString *name, void (^block)()) {
  SPT_describe(name, YES, block);
}

void context(NSString *name, void (^block)()) {
  SPT_describe(name, NO, block);
}
void fcontext(NSString *name, void (^block)()) {
  SPT_describe(name, YES, block);
}

void SPT_example(NSString *name, BOOL focused, id block) {
  SPT_returnUnlessBlockOrNil(block);
  [SPT_currentGroup addExampleWithName:name block:block focused:focused];
}

void example(NSString *name, id block) {
  SPT_example(name, NO, block);
}

void fexample(NSString *name, id block) {
  SPT_example(name, YES, block);
}

void it(NSString *name, id block) {
  SPT_example(name, NO, block);
}

void fit(NSString *name, id block) {
  SPT_example(name, YES, block);
}

void specify(NSString *name, id block) {
  SPT_example(name, NO, block);
}

void fspecify(NSString *name, id block) {
  SPT_example(name, YES, block);
}

void SPT_pending(NSString *name, ...) {
  SPT_example(name, NO, nil);
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

void SPT_itShouldBehaveLike(const char *fileName, NSUInteger lineNumber, NSString *name, id dictionaryOrBlock) {
  SPTDictionaryBlock block = [SPTSharedExampleGroups sharedExampleGroupWithName:name exampleGroup:SPT_currentGroup];
  if(block) {
    if(SPT_isBlock(dictionaryOrBlock)) {
      id (^dataBlock)(void) = [[dictionaryOrBlock copy] autorelease];

      describe(name, ^{
        __block NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];

        beforeEach(^{
          NSDictionary *blockData = dataBlock();
          [dataDict removeAllObjects];
          [dataDict addEntriesFromDictionary:blockData];
        });

        block(dataDict);

        afterAll(^{
          [dataDict release];
          dataDict = nil;
        });
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
      NSException *exception = [NSException failureInFile:[NSString stringWithUTF8String:fileName] atLine:(int)lineNumber withDescription:@"itShouldBehaveLike should not be invoked inside an example block!"];
      [currentTestCase failWithException: exception];
    } else {
      it(name, ^{
        NSException *exception = [NSException failureInFile:[NSString stringWithUTF8String:fileName] atLine:(int)lineNumber withDescription:[NSString stringWithFormat:@"Shared example group \"%@\" does not exist.", name]];
        [exception raise];
      });
    }
  }
}

void setAsyncSpecTimeout(NSTimeInterval timeout) {
  [SPTExampleGroup setAsyncSpecTimeout:timeout];
}
