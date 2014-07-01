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

void  beforeAll(id block);
void   afterAll(id block);
void beforeEach(id block);
void  afterEach(id block);
void     before(id block);
void      after(id block);

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
@interface name##Spec : SPTTestCase \
@end \
@implementation name##Spec \
- (void)spt_defineSpec { \
  const char *specFileName = file; \
  @try { \
    [self spt_setCurrentTestSuiteWithFileName:(file) lineNumber:(line)];

#define _SPTSpecEnd \
    [self spt_unsetCurrentTestSuite]; \
  } @catch(NSException *exception) { \
    fprintf(stderr, "%s: An exception has occured outside of tests, aborting.\n\n%s (%s) \n", specFileName, [[exception name] UTF8String], [[exception reason] UTF8String]); \
    if ([exception respondsToSelector:@selector(callStackSymbols)]) { \
      NSArray *callStackSymbols = [exception callStackSymbols]; \
      if (callStackSymbols) { \
        NSString *callStack = [NSString stringWithFormat:@"\n  Call Stack:\n    %@\n", [callStackSymbols componentsJoinedByString:@"\n    "]]; \
        fprintf(stderr, "%s", [callStack UTF8String]); \
      } \
    } \
    exit(1); \
  } \
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

#ifdef _SPT_XCODE6
  #undef _XCTRegisterFailure
  #define _XCTRegisterFailure(test, condition, format...) \
  ({ \
    @try { \
      _XCTFailureHandler((id)test, YES, __FILE__, __LINE__, condition, @"" format); \
    } @catch(NSException *e) { \
      NSString *description = [e reason]; \
      id line = [e userInfo][@"line"]; \
      id file = [e userInfo][@"file"]; \
      if ([line isKindOfClass:[NSNumber class]] && [file isKindOfClass:[NSString class]]) { \
        [test recordFailureWithDescription:description inFile:file atLine:[line unsignedIntegerValue] expected:YES]; \
      } else { \
        [test _recordUnexpectedFailureWithDescription:description exception:e]; \
      } \
    } \
  })
#else
  #undef _XCTRegisterFailure
  #define _XCTRegisterFailure(condition, format...) \
  ({ \
    _XCTFailureHandler((id)self, YES, __FILE__, __LINE__, condition, @"" format); \
  })
#endif
