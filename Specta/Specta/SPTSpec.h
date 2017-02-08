#import <XCTest/XCTest.h>
#import <Specta/XCTestCase+Specta.h>

@class
  SPTTestSuite
, SPTCompiledExample
;

typedef void (^CheckingBlock)(id obj);

@interface SPTCheckerObj: NSObject

@property (nonatomic, weak) id obj;
@property (nonatomic, strong) CheckingBlock checkBlock;
@end

@interface SPTSpec : XCTestCase

@property (strong) XCTestCaseRun *spt_run;
@property (nonatomic) BOOL spt_pending;
@property (nonatomic) BOOL spt_skipped;

+ (BOOL)spt_isDisabled;
+ (void)spt_setDisabled:(BOOL)disabled;
+ (BOOL)spt_focusedExamplesExist;
+ (SEL)spt_convertToTestMethod:(SPTCompiledExample *)example;
+ (SPTTestSuite *)spt_testSuite;
+ (void)spt_setCurrentTestSuite;
+ (void)spt_unsetCurrentTestSuite;
+ (void)spt_setCurrentTestSuiteFileName:(NSString *)fileName lineNumber:(NSUInteger)lineNumber;

- (void)spec;
- (BOOL)spt_shouldRunExample:(SPTCompiledExample *)example;
- (void)spt_runExample:(SPTCompiledExample *)example;
- (void)spt_checkThis:(id)obj;
@end
