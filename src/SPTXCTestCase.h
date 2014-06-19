#import <XCTest/XCTest.h>
#import "XCTestCase+Specta.h"

@class
  SPTSpec
, SPTExample
;

@interface SPTXCTestCase : XCTestCase

@property (strong) XCTestCaseRun *spt_run;
@property (nonatomic) BOOL spt_pending;
@property (nonatomic) BOOL spt_skipped;

+ (BOOL)spt_isDisabled;
+ (void)spt_setDisabled:(BOOL)disabled;
+ (BOOL)spt_focusedExamplesExist;
+ (SEL)spt_convertToTestMethod:(SPTExample *)example;
+ (SPTSpec *)spt_spec;

- (void)spt_setCurrentSpecWithFileName:(const char *)fileName lineNumber:(NSUInteger)lineNumber;
- (void)spt_defineSpec;
- (void)spt_unsetCurrentSpec;
- (void)spt_runExample:(SPTExample *)example;


@end
