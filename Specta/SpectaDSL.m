#import "SpectaDSL.h"
#import "SpectaTypes.h"
#import "SpectaUtility.h"
#import "SPTTestSuite.h"
#import "SPTExampleGroup.h"
#import "SPTSharedExampleGroups.h"
#import "SPTSpec.h"
#import <libkern/OSAtomic.h>

static NSTimeInterval asyncSpecTimeout = 10.0;

static void spt_defineItBlock(NSString *name, BOOL focused, void (^block)()) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addExampleWithName:name block:block focused:focused];
}

static void spt_defineDescribeBlock(NSString *name, BOOL focused, void (^block)()) {
  if (block) {
    [SPTGroupStack addObject:[SPTCurrentGroup addExampleGroupWithName:name focused:focused]];
    block();
    [SPTGroupStack removeLastObject];
  } else {
    spt_defineItBlock(name, focused, nil);
  }
}

void spt_describe(NSString *name, void (^block)()) {
  spt_defineDescribeBlock(name, NO, block);
}

void spt_fdescribe(NSString *name, void (^block)()) {
  spt_defineDescribeBlock(name, YES, block);
}

void spt_it(NSString *name, void (^block)()) {
  spt_defineItBlock(name, NO, block);
}

void spt_fit(NSString *name, void (^block)()) {
  spt_defineItBlock(name, YES, block);
}

void spt_pending(NSString *name, ...) {
  spt_defineItBlock(name, NO, nil);
}

void spt_beforeAll(void (^block)()) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addBeforeAllBlock:block];
}

void spt_afterAll(void (^block)()) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addAfterAllBlock:block];
}

void spt_beforeEach(void (^block)()) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addBeforeEachBlock:block];
}

void spt_afterEach(void (^block)()) {
  SPTReturnUnlessBlockOrNil(block);
  [SPTCurrentGroup addAfterEachBlock:block];
}

void spt_sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data)) {
  [SPTSharedExampleGroups addSharedExampleGroupWithName:name block:block exampleGroup:SPTCurrentGroup];
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
    SPTSpec *currentSpec = SPTCurrentSpec;
    if (currentSpec) {
      [currentSpec recordFailureWithDescription:@"itShouldBehaveLike should not be invoked inside an example block!" inFile:@(fileName) atLine:lineNumber expected:NO];
    } else {
      it(name, ^{
        [currentSpec recordFailureWithDescription:[NSString stringWithFormat:@"Shared example group \"%@\" does not exist.", name] inFile:@(fileName) atLine:lineNumber expected:NO];
      });
    }
  }
}

void spt_waitUntil(void (^block)(DoneCallback done)) {
  __block uint32_t complete = 0;
  dispatch_async(dispatch_get_main_queue(), ^{
    block(^{
      OSAtomicOr32Barrier(1, &complete);
    });
  });
  NSTimeInterval timeout = asyncSpecTimeout;
  NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
  while (!complete && [timeoutDate timeIntervalSinceNow] > 0) {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
  }
  if (!complete) {
    NSString *message = [NSString stringWithFormat:@"failed to invoke done() callback before timeout (%f seconds)", timeout];
    SPTSpec *currentSpec = SPTCurrentSpec;
    SPTTestSuite *testSuite = [[currentSpec class] spt_testSuite];
    [currentSpec recordFailureWithDescription:message inFile:testSuite.fileName atLine:testSuite.lineNumber expected:YES];
  }
}

void spt_setAsyncSpecTimeout(NSTimeInterval timeout) {
  asyncSpecTimeout = timeout;
}
