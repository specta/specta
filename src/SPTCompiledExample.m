#import "SPTCompiledExample.h"

@implementation SPTCompiledExample

- (id)initWithName:(NSString *)name block:(SPTTestCaseBlock)block pending:(BOOL)pending focused:(BOOL)focused {
  self = [super init];
  if (self) {
    self.name = name;
    self.block = block;
    self.pending = pending;
    self.focused = focused;
  }
  return self;
}

- (NSString *)underscoreName {
  NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"];
  return [[self.name componentsSeparatedByCharactersInSet:[charSet invertedSet]] componentsJoinedByString:@"_"];
}

@end