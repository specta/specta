#ifndef SPT_SUBCLASS
#define SPT_SUBCLASS SPTSenTestCase
#endif

#define _SPT_SpecBegin(name, file, line) \
@interface name##Spec : SPT_SUBCLASS \
@end \
@implementation name##Spec \
- (void)SPT_defineSpec { \
  [self SPT_setCurrentSpecWithFileName:(file) lineNumber:(line)];

#define _SPT_SpecEnd \
  [self SPT_unsetCurrentSpec]; \
} \
@end

#define _SPT_SharedExampleGroupsBegin(name) \
@interface name##SharedExampleGroups : SPTSharedExampleGroups \
@end \
@implementation name##SharedExampleGroups \
+ (void)defineSharedExampleGroups {

#define _SPT_SharedExampleGroupsEnd \
} \
@end
