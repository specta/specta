#import "SPTSpec.h"
#import "SPTExampleGroup.h"
#import "SPTExample.h"

@implementation SPTSpec

@synthesize
  rootGroup=_rootGroup
, groupStack=_groupStack
, compiledExamples=_compiledExamples
, fileName=_fileName
, lineNumber=_lineNumber
, disabled = _disabled
, hasFocusedExamples = _hasFocusedExamples
;


- (id)init {
  self = [super init];
  if(self) {
    self.rootGroup = [[SPTExampleGroup alloc] init];
    self.rootGroup.root = self.rootGroup;
    self.groupStack = [NSMutableArray arrayWithObject:self.rootGroup];
  }
  return self;
}

- (SPTExampleGroup *)currentGroup {
  return [self.groupStack lastObject];
}

- (void)compile {
  self.compiledExamples = [self.rootGroup compileExamplesWithNameStack:@[]];
  for (SPTExample * example in self.compiledExamples) {
    if (example.focused) {
      self.hasFocusedExamples = YES;
      break;
    }
  }
}

@end
