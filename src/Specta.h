#import <Foundation/Foundation.h>
#import "SPTTestCase.h"
#import "SPTExampleGroup.h"

#define SpecBegin(name) \
@interface name##Spec : SPTTestCase; @end \
@implementation name##Spec \
- (void)defineSpec { \
  [super defineSpec];

#define SpecEnd \
} \
@end

#define SpecGroupStack    [[self class] groupStack]
#define SpecCurrentGroup  [[self class] currentGroup]

#define beforeAll(block)  [SpecCurrentGroup addBeforeAllBlock:(block)]
#define afterAll(block)   [SpecCurrentGroup addAfterAllBlock:(block)]
#define beforeEach(block) [SpecCurrentGroup addBeforeEachBlock:(block)]
#define afterEach(block)  [SpecCurrentGroup addAfterEachBlock:(block)]
#define before(block)     beforeEach(block)
#define after(block)      afterEach(block)

#define _exampleGroup(name, blk) \
[SpecGroupStack addObject:[[[self class] currentGroup] addExampleGroupWithName:(name)]]; \
(blk)(); \
[SpecGroupStack removeLastObject]

#define describe(name, block) _exampleGroup((name), (block))
#define context(name, block)  _exampleGroup((name), (block))

#define _example(name, blk) \
[SpecCurrentGroup addExampleWithName:(name) block:(blk)]

#define example(name, block) _example((name), (block))
#define it(name, block)      _example((name), (block))
#define specify(name, block) _example((name), (block))

@interface Specta : NSObject
@end

