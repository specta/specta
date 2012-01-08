#import <SenTestingKit/SenTestingKit.h>
#import "SpectaSupport.h"

@class
  SPTSpec
;

@interface SPTSenTestCase : SenTestCase {
  NSInvocation *_SPT_invocation;
  SenTestCaseRun *_SPT_run;
}

@property (nonatomic, assign) NSInvocation *SPT_invocation;
@property (nonatomic, assign) SenTestCaseRun *SPT_run;

+ (SPTSpec *)SPT_spec;
+ (SPTSenTestCase *)SPT_singleton;
- (void)SPT_defineSpecBefore;
- (void)SPT_defineSpecAfter;
- (void)SPT_defineSpec;
- (void)SPT_runExampleAtIndex:(NSUInteger)index;

@end
