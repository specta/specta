#import <Foundation/Foundation.h>

@class
  SPTExample
, SPTExampleGroup
, SPTSenTestCase
;

@interface SPTSpec : NSObject {
  SPTExampleGroup *_rootGroup;
  NSMutableArray *_groupStack;
  NSArray *_compiledExamples;
  NSString *_fileName;
  NSUInteger _lineNumber;
  SPTSenTestCase *_testCase;
}

@property (nonatomic, retain) SPTExampleGroup *rootGroup;
@property (nonatomic, retain) NSMutableArray *groupStack;
@property (nonatomic, retain) NSArray *compiledExamples;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic) NSUInteger lineNumber;
@property (nonatomic, retain) SPTSenTestCase *testCase;

- (SPTExampleGroup *)currentGroup;
- (void)compile;

@end
