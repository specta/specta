#import <SenTestingKit/SenTestingKit.h>
#import "SenTestCase+Specta.h"

@class
  SPTSpec
, SPTExample
;

@interface SPTSenTestCase : SenTestCase {
  NSInvocation *_SPT_invocation;
  SenTestCaseRun *_SPT_run;
  BOOL _SPT_skipped;
}

@property (nonatomic, assign) NSInvocation *SPT_invocation;
@property (nonatomic, assign) SenTestCaseRun *SPT_run;
@property (nonatomic, assign) BOOL SPT_skipped;
@property (nonatomic, assign, readonly, getter = SPT_isPending) BOOL SPT_pending;

+ (BOOL)SPT_isDisabled;
+ (void)SPT_setDisabled:(BOOL)disabled;
+ (BOOL)SPT_focusedExamplesExist;

+ (SPTSpec *)SPT_spec;
- (void)SPT_setCurrentSpecWithFileName:(const char *)fileName lineNumber:(NSUInteger)lineNumber;
- (void)SPT_defineSpec;
- (void)SPT_unsetCurrentSpec;
- (void)SPT_runExampleAtIndex:(NSUInteger)index;
- (SPTExample *)SPT_getCurrentExample;

@end
