#import "SPTExample.h"

@implementation SPTExample

@synthesize
  name=_name
, block=_block
, pending=_pending
, focused=_focused
, parentGroup=_parentGroup
;

- (void)dealloc {
  self.name = nil;
  self.block = nil;
  [super dealloc];
}

- (id)initWithName:(NSString *)name block:(id)block parentGroup:(SPTExampleGroup *)parentGroup {
  self = [super init];
  if(self) {
    self.name = name;
    self.block = block;
    self.parentGroup = parentGroup;
    self.pending = block == nil;
  }
  return self;
}

@end

