#ifndef SPT_TESTCASE_HEADER
#  define SPT_TESTCASE_HEADER <SenTestingKit/SenTestingKit.h>
#endif
#ifndef SPT_TESTCASE_CLASS
#  define SPT_TESTCASE_CLASS SenTestCase
#endif

#import SPT_TESTCASE_HEADER

@class SPTExampleGroup;

@interface SPTTestCase : SPT_TESTCASE_CLASS

- (void)defineSpec;
+ (SPTExampleGroup *)rootGroup;
+ (NSMutableArray *)groupStack;
+ (SPTExampleGroup *)currentGroup;

@end

