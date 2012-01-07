typedef void (^SPTVoidBlock)();

#define _SPT_SpecBegin(name) \
@interface name##Spec : SPTTestCase; @end \
@implementation name##Spec \
- (void)defineSpec { \
[super defineSpec];

#define _SPT_SpecEnd \
} \
@end

#define SPTSpecGroupStack      [[self class] groupStack]
#define SPTSpecCurrentGroup    [[self class] currentGroup]

#define _SPT_beforeAll(block)  [SPTSpecCurrentGroup addBeforeAllBlock:(block)]
#define _SPT_afterAll(block)   [SPTSpecCurrentGroup addAfterAllBlock:(block)]
#define _SPT_beforeEach(block) [SPTSpecCurrentGroup addBeforeEachBlock:(block)]
#define _SPT_afterEach(block)  [SPTSpecCurrentGroup addAfterEachBlock:(block)]

#define _SPT_exampleGroup(name, blk) \
[SPTSpecGroupStack addObject:[SPTSpecCurrentGroup addExampleGroupWithName:(name)]]; \
(blk)(); \
[SPTSpecGroupStack removeLastObject]

#define _SPT_example(name, blk) \
[SPTSpecCurrentGroup addExampleWithName:(name) block:(blk)]
