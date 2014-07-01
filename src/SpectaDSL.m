#import "SpectaDSL.h"
#import "SpectaTypes.h"
#import "SpectaUtility.h"
#import "SPTTestSuite.h"
#import "SPTExampleGroup.h"
#import "SPTSharedExampleGroups.h"
#import "SPTTestCase.h"
#import <libkern/OSAtomic.h>

static NSTimeInterval asyncSpecTimeout = 10.0;

void spt_describe(NSString *name, BOOL focused, void (^block)()) {
  if (block) {
    [SPTGroupStack addObject:[SPTCurrentGroup addExampleGroupWithName:name focused:focused]];
    block();
    [SPTGroupStack removeLastObject];
  } else {
    spt_example(name, focused, nil);
  }
}

void describe(NSString *name, void (^block)()) {
  spt_describe(name, NO, block);
}

void fdescribe(NSString *name, void (^block)()) {
  spt_describe(name, YES, block);
}

void context(NSString *name, void (^block)()) {
  spt_describe(name, NO, block);
}
void fcontext(NSString *name, void (^block)()) {
  spt_describe(name, YES, block);
}

void spt_example(NSString *name, BOOL focused, void (^block)()) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addExampleWithName:name block:block focused:focused];
}

void example(NSString *name, void (^block)()) {
  spt_example(name, NO, block);
}

void fexample(NSString *name, void (^block)()) {
  spt_example(name, YES, block);
}

void it(NSString *name, void (^block)()) {
  spt_example(name, NO, block);
}

void fit(NSString *name, void (^block)()) {
  spt_example(name, YES, block);
}

void specify(NSString *name, void (^block)()) {
  spt_example(name, NO, block);
}

void fspecify(NSString *name, void (^block)()) {
  spt_example(name, YES, block);
}

void spt_pending(NSString *name, ...) {
  spt_example(name, NO, nil);
}

void beforeAll(id block) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addBeforeAllBlock:block];
}

void afterAll(id block) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addAfterAllBlock:block];
}

void beforeEach(id block) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addBeforeEachBlock:block];
}

void afterEach(id block) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addAfterEachBlock:block];
}

void before(id block) {
  beforeEach(block);
}

void after(id block) {
  afterEach(block);
}

void sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data)) {
  [SPTSharedExampleGroups addSharedExampleGroupWithName:name block:block exampleGroup:SPTCurrentGroup];
}

void sharedExamples(NSString *name, void (^block)(NSDictionary *data)) {
  sharedExamplesFor(name, block);
}

void spt_itShouldBehaveLike(const char *fileName, NSUInteger lineNumber, NSString *name, id dictionaryOrBlock) {
  SPTDictionaryBlock block = [SPTSharedExampleGroups sharedExampleGroupWithName:name exampleGroup:SPTCurrentGroup];
  if (block) {
    if (SPTIsBlock(dictionaryOrBlock)) {
      id (^dataBlock)(void) = [dictionaryOrBlock copy];

      describe(name, ^{
        __block NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];

        beforeEach(^{
          NSDictionary *blockData = dataBlock();
          [dataDict removeAllObjects];
          [dataDict addEntriesFromDictionary:blockData];
        });

        block(dataDict);

        afterAll(^{
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
    SPTTestCase *currentTestCase = SPTCurrentTestCase;
    if (currentTestCase) {
      [currentTestCase recordFailureWithDescription:@"itShouldBehaveLike should not be invoked inside an example block!" inFile:@(fileName) atLine:lineNumber expected:NO];
    } else {
      it(name, ^{
        [currentTestCase recordFailureWithDescription:[NSString stringWithFormat:@"Shared example group \"%@\" does not exist.", name] inFile:@(fileName) atLine:lineNumber expected:NO];
      });
    }
  }
}

void setAsyncSpecTimeout(NSTimeInterval timeout) {
  asyncSpecTimeout = timeout;
}

void waitUntil(void (^block)(DoneCallback done)) {
  __block uint32_t complete = 0;
  block(^{
    OSAtomicOr32Barrier(1, &complete);
  });
  NSTimeInterval timeout = asyncSpecTimeout;
  NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
  while (!complete && [timeoutDate timeIntervalSinceNow] > 0) {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
  }
  if (!complete) {
    NSString *message = [NSString stringWithFormat:@"failed to invoke done() callback before timeout (%f seconds)", timeout];
    SPTTestCase *currentTestCase = SPTCurrentTestCase;
    SPTTestSuite *testSuite = [[currentTestCase class] spt_testSuite];
    [currentTestCase recordFailureWithDescription:message inFile:testSuite.fileName atLine:testSuite.lineNumber expected:YES];
  }
}
