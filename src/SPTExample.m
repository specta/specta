#import "SPTExample.h"

@implementation SPTExample

@synthesize
  name=_name
, block=_block
, pending=_pending
, focused=_focused
;


- (id)initWithName:(NSString *)name block:(id)block {
  self = [super init];
  if(self) {
    self.name = name;
    self.block = block;
    self.pending = block == nil;
  }
  return self;
}

@end

