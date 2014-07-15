#import <XCTest/XCTest.h>

#define SpecBegin(name) _SPTSpecBegin(name, __FILE__, __LINE__)
#define SpecEnd         _SPTSpecEnd

#define SharedExamplesBegin(name)      _SPTSharedExampleGroupsBegin(name)
#define SharedExamplesEnd              _SPTSharedExampleGroupsEnd
#define SharedExampleGroupsBegin(name) _SPTSharedExampleGroupsBegin(name)
#define SharedExampleGroupsEnd         _SPTSharedExampleGroupsEnd

typedef void (^DoneCallback)(void);

// these functions are not actually implemented, but are present here to aid code-completion

void  describe(NSString *name, void (^block)());
void fdescribe(NSString *name, void (^block)());
void   context(NSString *name, void (^block)());
void  fcontext(NSString *name, void (^block)());

void       it(NSString *name, void (^block)());
void      fit(NSString *name, void (^block)());
void  example(NSString *name, void (^block)());
void fexample(NSString *name, void (^block)());
void  specify(NSString *name, void (^block)());
void fspecify(NSString *name, void (^block)());

void  beforeAll(void (^block)());
void   afterAll(void (^block)());
void     before(void (^block)());
void      after(void (^block)());
void beforeEach(void (^block)());
void  afterEach(void (^block)());

void sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data));
void    sharedExamples(NSString *name, void (^block)(NSDictionary *data));

void itShouldBehaveLike(NSString *name, id dictionaryOrBlockOrNil);
void      itBehavesLike(NSString *name, id dictionaryOrBlockOrNil);

void waitUntil(void (^block)(DoneCallback done));

void setAsyncSpecTimeout(NSTimeInterval timeout);

// namespace all functions, so that these won't get in the way of their Swift counterparts.

void spt_describe(NSString *name, void (^block)());
void spt_fdescribe(NSString *name, void (^block)());

void spt_it(NSString *name, void (^block)());
void spt_fit(NSString *name, void (^block)());

void spt_pending(NSString *name, ...);

void spt_beforeAll(void (^block)());
void spt_afterAll(void (^block)());
void spt_beforeEach(void (^block)());
void spt_afterEach(void (^block)());

void spt_sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data));

void spt_itShouldBehaveLike(const char *fileName, NSUInteger lineNumber, NSString *name, id dictionaryOrBlock);

void spt_waitUntil(void (^block)(DoneCallback done));

void spt_setAsyncSpecTimeout(NSTimeInterval timeout);

// ---

#define  describe spt_describe
#define fdescribe spt_fdescribe
#define   context spt_describe
#define  fcontext spt_fcontext

#define       it spt_it
#define      fit spt_fit
#define  example spt_it
#define fexample spt_fit
#define  specify spt_it
#define fspecify spt_fit

#define   pending(...) spt_pending(__VA_ARGS__, nil)
#define xdescribe(...) spt_pending(__VA_ARGS__, nil)
#define  xcontext(...) spt_pending(__VA_ARGS__, nil)
#define  xexample(...) spt_pending(__VA_ARGS__, nil)
#define       xit(...) spt_pending(__VA_ARGS__, nil)
#define  xspecify(...) spt_pending(__VA_ARGS__, nil)

#define  beforeAll spt_beforeAll
#define   afterAll spt_afterAll
#define     before spt_beforeEach
#define      after spt_afterEach
#define beforeEach spt_beforeEach
#define  afterEach spt_afterEach

#define sharedExamplesFor spt_sharedExamplesFor
#define    sharedExamples spt_sharedExamplesFor

#define  itShouldBehaveLike(...) spt_itShouldBehaveLike(__FILE__, __LINE__, __VA_ARGS__)
#define       itBehavesLike(...) spt_itShouldBehaveLike(__FILE__, __LINE__, __VA_ARGS__)

#define setAsyncSpecTimeout spt_setAsyncSpecTimeout
#define waitUntil spt_waitUntil


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