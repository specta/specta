#import "SenTestLog+Specta.h"
#import "SPTReporter.h"
#import "SPTSenTestCase.h"
#import "SPTExample.h"

#define SPTSharedReporter ([SPTReporter sharedReporter])

@implementation SenTestLog (Specta)

+ (void) testSuiteDidStart:(NSNotification *) aNotification
{
  [SPTSharedReporter testSuiteDidBegin:aNotification.object];
}

+ (void) testSuiteDidStop:(NSNotification *) aNotification
{
  [SPTSharedReporter testSuiteDidEnd:aNotification.object];
}

+ (void) testCaseDidStart:(NSNotification *) aNotification
{
  [SPTSharedReporter testCaseDidBegin:aNotification.object];
}

+ (void) testCaseDidStop:(NSNotification *) aNotification
{
  [SPTSharedReporter testCaseDidEnd:aNotification.object];
}

+ (void) testCaseDidFail:(NSNotification *) aNotification
{
  [SPTSharedReporter testCaseDidFail:aNotification.object];
}

@end
