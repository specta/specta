#import "TestHelper.h"
#import "SPTReporter.h"
#import "SPTDefaultReporter.h"

@interface CustomReporterTestReporter : SPTDefaultReporter
@end

@implementation CustomReporterTestReporter
@end

@interface CustomReporterTest : SenTestCase

@end

@implementation CustomReporterTest

//
// Because this test relies on a global environment variable, it needs to be run in both cases. I've used a custom
// scheme for this to avoid conflicting with the main test run.
//
- (void)test_custom_reporter_is_used
{
  NSString * customReporterClassName = [NSProcessInfo processInfo].environment[@"SPECTA_REPORTER_CLASS"];
  if (customReporterClassName != nil)
  {
    STAssertEqualObjects([[SPTReporter sharedReporter] className],
                         customReporterClassName,
                         @"Specta should load the custom reporter from the SPECTA_REPORTER_CLASS environment variable");
  }
  else
  {
    STAssertEqualObjects([[SPTReporter sharedReporter] className],
                         @"SPTDefaultReporter",
                         @"Specta should use SPTDefaultReporter when SPECTA_REPORTER_CLASS variable is not set");
  }
}

@end