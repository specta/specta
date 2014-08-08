#import <XCTest/XCTest.h>

#define SpecBegin(name) _SPTSpecBegin(name, __FILE__, __LINE__)
#define SpecEnd         _SPTSpecEnd

#define SharedExamplesBegin(name)      _SPTSharedExampleGroupsBegin(name)
#define SharedExamplesEnd              _SPTSharedExampleGroupsEnd
#define SharedExampleGroupsBegin(name) _SPTSharedExampleGroupsBegin(name)
#define SharedExampleGroupsEnd         _SPTSharedExampleGroupsEnd

typedef void (^DoneCallback)(void);

// namespace all functions, so that these won't get in the way of their Swift counterparts.

void spt_describe(NSString *name, void (^block)());
void spt_fdescribe(NSString *name, void (^block)());

void spt_it(NSString *name, void (^block)());
void spt_fit(NSString *name, void (^block)());

void spt_it_(NSString *name, NSString *fileName, NSUInteger lineNumber, void (^block)());
void spt_fit_(NSString *name, NSString *fileName, NSUInteger lineNumber, void (^block)());

void spt_pending_(NSString *name, ...);
#define   spt_pending(...) spt_pending_(__VA_ARGS__, nil)
#define spt_xdescribe(...) spt_pending_(__VA_ARGS__, nil)
#define  spt_xcontext(...) spt_pending_(__VA_ARGS__, nil)
#define  spt_xexample(...) spt_pending_(__VA_ARGS__, nil)
#define       spt_xit(...) spt_pending_(__VA_ARGS__, nil)
#define  spt_xspecify(...) spt_pending_(__VA_ARGS__, nil)

void spt_beforeAll(void (^block)());
void spt_afterAll(void (^block)());
void spt_beforeEach(void (^block)());
void spt_afterEach(void (^block)());

void spt_sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data));
#define spt_sharedExamples

void spt_itShouldBehaveLike_(NSString *fileName, NSUInteger lineNumber, NSString *name, id dictionaryOrBlock);
void spt_itShouldBehaveLike_block(NSString *fileName, NSUInteger lineNumber, NSString *name, NSDictionary *(^block)());
#define spt_itShouldBehaveLike(...) spt_itShouldBehaveLike_(@(__FILE__), __LINE__, __VA_ARGS__)
#define      spt_itBehavesLike(...) spt_itShouldBehaveLike_(@(__FILE__), __LINE__, __VA_ARGS__)


void spt_waitUntil(void (^block)(DoneCallback done));

void spt_setAsyncSpecTimeout(NSTimeInterval timeout);

#define _SPTSpecBegin(name, file, line) \
@interface name##Spec : SPTSpec \
@end \
@implementation name##Spec \
- (void)spec { \
  [[self class] spt_setCurrentTestSuiteFileName:(@(file)) lineNumber:(line)];

#define _SPTSpecEnd \
} \
@end

#define _SPTSharedExampleGroupsBegin(name) \
@interface name##SharedExampleGroups : SPTSharedExampleGroups \
@end \
@implementation name##SharedExampleGroups \
+ (void)defineSharedExampleGroups {

#define _SPTSharedExampleGroupsEnd \
} \
@end