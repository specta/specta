#import <Foundation/Foundation.h>

@class
  SPTExample
, SPTExampleGroup
;

@interface SPTSpec : NSObject {
  SPTExampleGroup *_rootGroup;
  NSMutableArray *_groupStack;
  NSArray *_compiledExamples;
  NSString *_fileName;
  NSUInteger _lineNumber;
  BOOL _hasFocusedExamples;
  BOOL _disabled;
}

@property (nonatomic, strong) SPTExampleGroup *rootGroup;
@property (nonatomic, strong) NSMutableArray *groupStack;
@property (nonatomic, strong) NSArray *compiledExamples;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic) NSUInteger lineNumber;
@property (nonatomic, getter = isDisabled) BOOL disabled;
@property (nonatomic) BOOL hasFocusedExamples;

- (SPTExampleGroup *)currentGroup;
- (void)compile;

@end
