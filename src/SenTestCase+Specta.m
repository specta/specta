#import "SenTestCase+Specta.h"
#import "SPTSenTestCase.h"

@implementation SenTestCase (Specta)

- (NSString *)SPT_title
{
  if ([self isKindOfClass:[SPTSenTestCase class]])
  {
    SPTExample * example = [(SPTSenTestCase *)self SPT_getCurrentExample];
    return [example name];
  }
  else
  {
    return NSStringFromSelector([self selector]);
  }
}

@end
