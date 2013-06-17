#import <SenTestingKit/SenTestingKit.h>

@interface SenTestRun (Specta)

- (void)SPT_visitTestCaseRunsWithBlock:(void(^)(SenTestCaseRun * testRun))block;

// ===== PENDING TEST CASES ============================================================================================
#pragma mark - Pending Test Cases

- (NSUInteger)pendingTestCaseCount;

@end
