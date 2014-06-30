#import "SPTExample.h"

@implementation SPTExample

- (id)initWithName:(NSString *)name block:(SPTVoidBlock)block {
  self = [super init];
  if (self) {
    self.name = name;
    self.block = block;
    self.pending = block == nil;
    self.focused = NO;
  }
  return self;
}

@end

