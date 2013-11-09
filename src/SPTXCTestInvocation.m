#import "SPTXCTestInvocation.h"

@implementation SPTXCTestInvocation

- (void)invoke {
  if (self.spt_invocationBlock) {
    self.spt_invocationBlock();
  }
}

@end
