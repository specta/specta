#import <SenTestingKit/SenTestingKit.h>

@interface SPTReporter : SenTestObserver {
  NSArray *_runStack;
}

// ===== SHARED REPORTER ===============================================================================================
#pragma mark - Shared Reporter

+ (SPTReporter *)sharedReporter;

// ===== RUN STACK =====================================================================================================
#pragma mark - Run Stack

@property (nonatomic, retain) NSArray *runStack;

// ===== TEST SUITE ====================================================================================================
#pragma mark - Test Suite

- (void)testSuiteDidBegin:(SenTestSuiteRun *)suiteRun;
- (void)testSuiteDidEnd:(SenTestSuiteRun *)suiteRun;

// ===== TEST CASES ====================================================================================================
#pragma mark - Test Cases

- (void)testCaseDidBegin:(SenTestCaseRun *)testCaseRun;
- (void)testCaseDidEnd:(SenTestCaseRun *)testCaseRun;
- (void)testCaseDidFail:(SenTestCaseRun *)testCaseRun;

// ===== PRINTING ======================================================================================================
#pragma mark - Printing

- (void)printString:(NSString *)string;
- (void)printStringWithFormat:(NSString *)formatString, ... NS_FORMAT_FUNCTION(1,2);

- (void)printLine;
- (void)printLine:(NSString *)line;
- (void)printLineWithFormat:(NSString *)formatString, ... NS_FORMAT_FUNCTION(1,2);


@end
