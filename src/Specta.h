#import <Foundation/Foundation.h>
#import "SpectaSupport.h"
#import "SPTSenTestCase.h"
#import "SPTSpec.h"
#import "SPTExampleGroup.h"

@interface Specta : NSObject
@end

#define SpecBegin(name)    _SPT_SpecBegin(name, __FILE__, __LINE__)
#define SpecEnd            _SPT_SpecEnd

#ifdef SPT_CEDAR_SYNTAX
#  define SPEC_BEGIN(name) SpecBegin(name)
#  define SPEC_END         SpecEnd
#endif

void   describe(NSString *name, void (^block)());
void    context(NSString *name, void (^block)());

void    example(NSString *name, void (^block)());
void         it(NSString *name, void (^block)());
void    specify(NSString *name, void (^block)());

void  beforeAll(void (^block)());
void   afterAll(void (^block)());
void beforeEach(void (^block)());
void  afterEach(void (^block)());
void     before(void (^block)());
void      after(void (^block)());
