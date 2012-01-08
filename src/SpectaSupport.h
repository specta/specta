typedef void (^SPTVoidBlock)();

#define _SPT_SpecBegin(name) \
@interface name##Spec : SPTSenTestCase \
@end \
@implementation name##Spec \
- (void)SPT_defineSpec { \
  [self SPT_defineSpecBefore];

#define _SPT_SpecEnd \
  [self SPT_defineSpecAfter]; \
} \
@end
