#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import "SpectaTypes.h"

@class
  SPTExample
;

@interface SPTExampleGroup : NSObject {
  NSString *_name;
  SPTExampleGroup *_root;
  SPTExampleGroup *_parent;
  NSMutableArray *_children;
  NSMutableArray *_beforeAllArray;
  NSMutableArray *_afterAllArray;
  NSMutableArray *_beforeEachArray;
  NSMutableArray *_afterEachArray;
  NSMutableDictionary *_sharedExamples;
  unsigned int _exampleCount;
  unsigned int _ranExampleCount;
  BOOL _focused;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) SPTExampleGroup *root;
@property (nonatomic, assign) SPTExampleGroup *parent;
@property (nonatomic, retain) NSMutableArray *children;
@property (nonatomic, retain) NSMutableArray *beforeAllArray;
@property (nonatomic, retain) NSMutableArray *afterAllArray;
@property (nonatomic, retain) NSMutableArray *beforeEachArray;
@property (nonatomic, retain) NSMutableArray *afterEachArray;
@property (nonatomic, retain) NSMutableDictionary *sharedExamples;
@property (nonatomic) unsigned int exampleCount;
@property (nonatomic) unsigned int ranExampleCount;
@property (nonatomic, getter=isFocused) BOOL focused;

+ (void)setAsyncSpecTimeout:(NSTimeInterval)timeout;
- (id)initWithName:(NSString *)name parent:(SPTExampleGroup *)parent root:(SPTExampleGroup *)root;

- (SPTExampleGroup *)addExampleGroupWithName:(NSString *)name;
- (SPTExampleGroup *)addExampleGroupWithName:(NSString *)name  focused:(BOOL)focused;

- (SPTExample *)addExampleWithName:(NSString *)name block:(id)block;
- (SPTExample *)addExampleWithName:(NSString *)name block:(id)block focused:(BOOL)focused;

- (void)addBeforeAllBlock:(SPTVoidBlock)block;
- (void)addAfterAllBlock:(SPTVoidBlock)block;
- (void)addBeforeEachBlock:(SPTVoidBlock)block;
- (void)addAfterEachBlock:(SPTVoidBlock)block;

- (NSArray *)compileExamplesWithNameStack:(NSArray *)nameStack;

@end
