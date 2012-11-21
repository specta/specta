#import "SPTExample.h"

@implementation SPTExample

@synthesize
  name=_name
, block=_block
, pending=_pending
;

- (void)dealloc {
  self.name = nil;
  self.block = nil;
  [super dealloc];
}

- (id)initWithName:(NSString *)name block:(SPTVoidBlock)block {
  self = [super init];
  if(self) {
    self.name = name;
    self.block = block;
    self.pending = NO;
  }
  return self;
}

@end

