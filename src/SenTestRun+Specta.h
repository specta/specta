#import <SenTestingKit/SenTestingKit.h>

@interface SenTestRun (Specta)

- (void)SPT_visitTestCaseRunsWithBlock:(void(^)(SenTestCaseRun * testRun))block;

@end
