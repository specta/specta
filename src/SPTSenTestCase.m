#import "SPTSenTestCase.h"
#import "SPTSpec.h"
#import "SPTExample.h"
#import <objc/runtime.h>

@interface NSObject (SPTSenTestCase)

+ (NSArray *)senAllSuperclasses;

@end

@implementation SPTSenTestCase

@synthesize
  SPT_invocation=_SPT_invocation
, SPT_run=_SPT_run
;

- (void)dealloc {
  self.SPT_invocation = nil;
  self.SPT_run = nil;
  [super dealloc];
}

+ (void)initialize {
  SPTSpec *spec = [[SPTSpec alloc] init];
  SPTSenTestCase *testCase = [[[self class] alloc] init];
  objc_setAssociatedObject(self, "SPT_spec", spec, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [testCase SPT_defineSpec];
  [testCase release];
  [spec compile];
  [spec release];
  [super initialize];
}

+ (SPTSpec *)SPT_spec {
  return objc_getAssociatedObject(self, "SPT_spec");
}

- (void)SPT_defineSpecBefore {
  [[[NSThread currentThread] threadDictionary] setObject:[[self class] SPT_spec] forKey:@"SPT_currentSpec"];
}

- (void)SPT_defineSpec {}

- (void)SPT_defineSpecAfter {
  [[[NSThread currentThread] threadDictionary] removeObjectForKey:@"SPT_currentSpec"];
}

- (void)SPT_runExampleAtIndex:(NSUInteger)index {
  [[[NSThread currentThread] threadDictionary] setObject:self forKey:@"SPT_currentTestCase"];
  SPTExample *compiledExample = [[[self class] SPT_spec].compiledExamples objectAtIndex:index];
  compiledExample.block();
  [[[NSThread currentThread] threadDictionary] removeObjectForKey:@"SPT_currentTestCase"];
}

#pragma mark - SenTestCase overrides

+ (NSArray *)testInvocations {
  NSMutableArray *invocations = [NSMutableArray array];
  for(NSUInteger i = 0; i < [[self SPT_spec].compiledExamples count]; i ++) {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:@selector(SPT_runExampleAtIndex:)]];
    [invocation setSelector:@selector(SPT_runExampleAtIndex:)];
    [invocation setArgument:&i atIndex:2];
    [invocations addObject:invocation];
  }
  return invocations;
}

- (void)setInvocation:(NSInvocation *)invocation {
  self.SPT_invocation = invocation;
  [super setInvocation:invocation];
}

- (NSString *)name {
  NSString *specName = NSStringFromClass([self class]);
  NSUInteger i;
  [self.SPT_invocation getArgument:&i atIndex:2];
  SPTExample *compiledExample = [[[self class] SPT_spec].compiledExamples objectAtIndex:i];
  NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"];
  NSString *exampleName = [[compiledExample.name componentsSeparatedByCharactersInSet:[charSet invertedSet]] componentsJoinedByString:@"_"];
  return [NSString stringWithFormat:@"-[%@ %@]", specName, exampleName];
}

- (void)logException:(NSException *)exception {
  SPTSenTestCase *currentTestCase = [[[NSThread currentThread] threadDictionary] objectForKey:@"SPT_currentTestCase"];
  [currentTestCase.SPT_run addException:exception];
}

- (void)performTest:(SenTestRun *)run {
  self.SPT_run = (SenTestCaseRun *)run;
  [super performTest:run];
  self.SPT_run = nil;
}

+ (NSArray *)senAllSuperclasses {
  NSArray *arr = [super senAllSuperclasses];
  if([arr objectAtIndex:0] == [SPTSenTestCase class]) {
    return [NSArray arrayWithObject:[NSObject class]];
  }
  return arr;
}

@end
