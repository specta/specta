#import <XCTest/XCTest.h>

#define SpecBegin(name)    _SPTSpecBegin(name, __FILE__, __LINE__)
#define SpecEnd            _SPTSpecEnd

#define SharedExamplesBegin(name)      _SPTSharedExampleGroupsBegin(name)
#define SharedExamplesEnd              _SPTSharedExampleGroupsEnd
#define SharedExampleGroupsBegin(name) _SPTSharedExampleGroupsBegin(name)
#define SharedExampleGroupsEnd         _SPTSharedExampleGroupsEnd

void spt_describe(NSString *name, BOOL focused, void (^block)());
void     describe(NSString *name, void (^block)());
void    fdescribe(NSString *name, void (^block)());
void      context(NSString *name, void (^block)());
void     fcontext(NSString *name, void (^block)());

void spt_example(NSString *name, BOOL focused, void (^block)());
void     example(NSString *name, void (^block)());
void    fexample(NSString *name, void (^block)());
void          it(NSString *name, void (^block)());
void         fit(NSString *name, void (^block)());
void     specify(NSString *name, void (^block)());
void    fspecify(NSString *name, void (^block)());


void spt_pending(NSString *name, ...);
#define xdescribe(...) spt_pending(__VA_ARGS__, nil)
#define  xcontext(...) spt_pending(__VA_ARGS__, nil)
#define  xexample(...) spt_pending(__VA_ARGS__, nil)
#define       xit(...) spt_pending(__VA_ARGS__, nil)
#define  xspecify(...) spt_pending(__VA_ARGS__, nil)
#define   pending(...) spt_pending(__VA_ARGS__, nil)

void  beforeAll(void (^block)());
void   afterAll(void (^block)());
void beforeEach(void (^block)());
void  afterEach(void (^block)());
void     before(void (^block)());
void      after(void (^block)());

void sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data));
void    sharedExamples(NSString *name, void (^block)(NSDictionary *data));

void spt_itShouldBehaveLike(const char *fileName, NSUInteger lineNumber, NSString *name, id dictionaryOrBlock);
void     itShouldBehaveLike(NSString *name, id dictionaryOrBlockOrNil); // aid code completion
void          itBehavesLike(NSString *name, id dictionaryOrBlockOrNil);
#define  itShouldBehaveLike(...) spt_itShouldBehaveLike(__FILE__, __LINE__, __VA_ARGS__)
#define       itBehavesLike(...) spt_itShouldBehaveLike(__FILE__, __LINE__, __VA_ARGS__)

void setAsyncSpecTimeout(NSTimeInterval timeout);

typedef void (^DoneCallback)(void);
void waitUntil(void (^block)(DoneCallback done));

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