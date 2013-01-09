#ifndef SPT_SUBCLASS
#define SPT_SUBCLASS SPTSenTestCase
#endif

#define _SPT_SpecBegin(name, file, line) \
@interface name##Spec : SPT_SUBCLASS \
@end \
@implementation name##Spec \
- (void)SPT_defineSpec { \
  const char *SPT_specFileName = file; \
  @try { \
    [self SPT_setCurrentSpecWithFileName:(file) lineNumber:(line)];

#define _SPT_SpecEnd \
    [self SPT_unsetCurrentSpec]; \
  } @catch(NSException *exception) { \
    fprintf(stderr, "%s: An exception has occured outside of tests, aborting.\n\n%s (%s) \n", SPT_specFileName, [[exception name] UTF8String], [[exception reason] UTF8String]); \
    if([exception respondsToSelector:@selector(callStackSymbols)]) { \
      NSArray *callStackSymbols = [exception callStackSymbols]; \
      if(callStackSymbols) { \
        NSString *callStack = [NSString stringWithFormat:@"\n  Call Stack:\n    %@\n", [callStackSymbols componentsJoinedByString:@"\n    "]]; \
        fprintf(stderr, "%s", [callStack UTF8String]); \
      } \
    } \
    exit(1); \
  } \
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
