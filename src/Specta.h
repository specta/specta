#import <Foundation/Foundation.h>
#import "SpectaSupport.h"
#import "SPTSenTestCase.h"
#import "SPTSpec.h"
#import "SPTExampleGroup.h"
#import "SPTSharedExampleGroups.h"
#import "SenTestRun+Specta.h"

@interface Specta : NSObject
@end

#define SpecBegin(name)    _SPT_SpecBegin(name, __FILE__, __LINE__)
#define SpecEnd            _SPT_SpecEnd

#define SharedExamplesBegin(name)      _SPT_SharedExampleGroupsBegin(name)
#define SharedExamplesEnd              _SPT_SharedExampleGroupsEnd
#define SharedExampleGroupsBegin(name) _SPT_SharedExampleGroupsBegin(name)
#define SharedExampleGroupsEnd         _SPT_SharedExampleGroupsEnd

#ifdef SPT_CEDAR_SYNTAX
#  define SPEC_BEGIN(name) SpecBegin(name)
#  define SPEC_END         SpecEnd
#  define SHARED_EXAMPLE_GROUPS_BEGIN(name) SharedExamplesBegin(name)
#  define SHARED_EXAMPLE_GROUPS_END         SharedExamplesEnd
#  ifndef PENDING
#    define PENDING nil
#  endif
#endif

void SPT_describe(NSString *name, BOOL focused, void (^block)());
void     describe(NSString *name, void (^block)());
void    fdescribe(NSString *name, void (^block)());
void      context(NSString *name, void (^block)());
void     fcontext(NSString *name, void (^block)());

void SPT_example(NSString *name, BOOL focused, void (^block)());
void     example(NSString *name, void (^block)());
void    fexample(NSString *name, void (^block)());
void          it(NSString *name, void (^block)());
void         fit(NSString *name, void (^block)());
void     specify(NSString *name, void (^block)());
void    fspecify(NSString *name, void (^block)());


void SPT_pending(NSString *name, ...);
#define xdescribe(...) SPT_pending(__VA_ARGS__, nil)
#define  xcontext(...) SPT_pending(__VA_ARGS__, nil)
#define  xexample(...) SPT_pending(__VA_ARGS__, nil)
#define       xit(...) SPT_pending(__VA_ARGS__, nil)
#define  xspecify(...) SPT_pending(__VA_ARGS__, nil)
#define   pending(...) SPT_pending(__VA_ARGS__, nil)

void  beforeAll(void (^block)());
void   afterAll(void (^block)());
void beforeEach(void (^block)());
void  afterEach(void (^block)());
void     before(void (^block)());
void      after(void (^block)());

void sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data));
void    sharedExamples(NSString *name, void (^block)(NSDictionary *data));

void SPT_itShouldBehaveLike(const char *fileName, NSUInteger lineNumber, NSString *name, id dictionaryOrBlock);
void itShouldBehaveLike(NSString *name, id dictionaryOrBlockOrNil); // aid code completion
void      itBehavesLike(NSString *name, id dictionaryOrBlockOrNil);
#define itShouldBehaveLike(...) SPT_itShouldBehaveLike(__FILE__, __LINE__, __VA_ARGS__)
#define      itBehavesLike(...) SPT_itShouldBehaveLike(__FILE__, __LINE__, __VA_ARGS__)

// Requires Apple LLVM Compiler (Clang)
void setAsyncSpecTimeout(NSTimeInterval timeout);
#define AsyncBlock (void (^done)(void))