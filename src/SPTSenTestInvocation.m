#import "SPTSenTestInvocation.h"

@implementation SPTSenTestInvocation

@synthesize
  SPT_invocationBlock=_SPT_invocationBlock
;


- (void)invoke {
  if(self.SPT_invocationBlock) {
    self.SPT_invocationBlock();
  }
}

@end
