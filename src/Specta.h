#import <Foundation/Foundation.h>
#import "SpectaSupport.h"
#import "SPTSenTestCase.h"
#import "SPTSpec.h"
#import "SPTExampleGroup.h"
#import "SPTSharedExampleGroups.h"

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
#endif

#define AsyncBlock (void (^done)())

void   describe(NSString *name, void (^block)());
void    context(NSString *name, void (^block)());

void    example(NSString *name, id block);
void         it(NSString *name, id block);
void    specify(NSString *name, id block);

void SPT_pending(NSString *name, ...);
#define xdescribe(...) SPT_pending(__VA_ARGS__, nil)
#define  xcontext(...) SPT_pending(__VA_ARGS__, nil)
#define  xexample(...) SPT_pending(__VA_ARGS__, nil)
#define       xit(...) SPT_pending(__VA_ARGS__, nil)
#define  xspecify(...) SPT_pending(__VA_ARGS__, nil)
#define   pending(...) SPT_pending(__VA_ARGS__, nil)

void  beforeAll(id block);
void   afterAll(id block);
void beforeEach(id block);
void  afterEach(id block);
void     before(id block);
void      after(id block);

void sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data));
void    sharedExamples(NSString *name, void (^block)(NSDictionary *data));

void itShouldBehaveLike(NSString *name, id dictionaryOrBlock);
void      itBehavesLike(NSString *name, id dictionaryOrBlock);

void setAsyncSpecTimeout(NSTimeInterval timeout);
