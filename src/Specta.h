#import <Foundation/Foundation.h>
#import "SpectaSupport.h"
#import "SPTTestCase.h"
#import "SPTExampleGroup.h"

#define SPT_SpecBegin(name)       _SPT_SpecBegin(name)
#define SPT_SpecEnd               _SPT_SpecEnd

#define SPT_describe(name, block) _SPT_exampleGroup((name), (block))
#define SPT_context(name, block)  _SPT_exampleGroup((name), (block))

#define SPT_example(name, block)  _SPT_example((name), (block))
#define SPT_it(name, block)       _SPT_example((name), (block))
#define SPT_specify(name, block)  _SPT_example((name), (block))

#define SPT_beforeAll(block)      _SPT_beforeAll((block))
#define SPT_afterAll(block)       _SPT_afterAll((block))
#define SPT_beforeEach(block)     _SPT_beforeEach((block))
#define SPT_afterEach(block)      _SPT_afterEach((block))
#define SPT_before(block)         _SPT_beforeEach((block))
#define SPT_after(block)          _SPT_afterEach((block))

#ifdef SPT_SHORTHAND
#  define SpecBegin(name)         SPT_SpecBegin(name)
#  define SpecEnd                 SPT_SpecEnd
#
#  define describe(name, block)   SPT_describe((name), (block))
#  define context(name, block)    SPT_context((name), (block))
#
#  define example(name, block)    SPT_example((name), (block))
#  define it(name, block)         SPT_it((name), (block))
#  define specify(name, block)    SPT_specify((name), (block))
#
#  define beforeAll(block)        SPT_beforeAll((block))
#  define afterAll(block)         SPT_afterAll((block))
#  define beforeEach(block)       SPT_beforeEach((block))
#  define afterEach(block)        SPT_afterEach((block))
#  define before(block)           SPT_beforeEach((block))
#  define after(block)            SPT_afterEach((block))
#endif

@interface Specta : NSObject
@end

