#import <Foundation/Foundation.h>

@class
  SPTExample
, SPTExampleGroup
;

@interface SPTSpec : NSObject {
  SPTExampleGroup *_rootGroup;
  NSMutableArray *_groupStack;
  NSArray *_compiledExamples;
}

@property (nonatomic, retain) SPTExampleGroup *rootGroup;
@property (nonatomic, retain) NSMutableArray *groupStack;
@property (nonatomic, retain) NSArray *compiledExamples;

- (SPTExampleGroup *)currentGroup;
- (void)compile;

@end
