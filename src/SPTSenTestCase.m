#import "SPTSenTestCase.h"
#import "SPTSpec.h"
#import "SPTExample.h"
#import "SPTSenTestInvocation.h"
#import "SPTSharedExampleGroups.h"
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
  [SPTSharedExampleGroups initialize];
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

- (void)SPT_setCurrentSpecWithFileName:(const char *)fileName lineNumber:(NSUInteger)lineNumber {
  SPTSpec *spec = [[self class] SPT_spec];
  spec.fileName = [NSString stringWithUTF8String:fileName];
  spec.lineNumber = lineNumber;
  [[[NSThread currentThread] threadDictionary] setObject:spec forKey:@"SPT_currentSpec"];
}

- (void)SPT_defineSpec {}

- (void)SPT_unsetCurrentSpec {
  [[[NSThread currentThread] threadDictionary] removeObjectForKey:@"SPT_currentSpec"];
}

- (void)SPT_runExampleAtIndex:(NSUInteger)index {
  [[[NSThread currentThread] threadDictionary] setObject:self forKey:@"SPT_currentTestCase"];
  SPTExample *compiledExample = [[[self class] SPT_spec].compiledExamples objectAtIndex:index];
  fprintf(stderr, "  %s%s\n", [compiledExample.name UTF8String], compiledExample.pending ? " (pending)" : "");
  if(!compiledExample.pending) {
    compiledExample.block();
  }
  [[[NSThread currentThread] threadDictionary] removeObjectForKey:@"SPT_currentTestCase"];
}

- (SPTExample *)SPT_getCurrentExample {
  if(!self.SPT_invocation) {
    return nil;
  }
  NSUInteger i;
  [self.SPT_invocation getArgument:&i atIndex:2];
  return [[[self class] SPT_spec].compiledExamples objectAtIndex:i];
}

#pragma mark - SenTestCase overrides

+ (NSArray *)testInvocations {
  NSMutableArray *invocations = [NSMutableArray array];
  for(NSUInteger i = 0; i < [[self SPT_spec].compiledExamples count]; i ++) {
    SPTSenTestInvocation *invocation = (SPTSenTestInvocation *)[SPTSenTestInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:@selector(SPT_runExampleAtIndex:)]];
    invocation.SPT_invocationBlock = ^{
      [(SPTSenTestCase *)[invocation target] SPT_runExampleAtIndex:i];
    };
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
  SPTExample *compiledExample = [self SPT_getCurrentExample];
  NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"];
  NSString *exampleName = [[compiledExample.name componentsSeparatedByCharactersInSet:[charSet invertedSet]] componentsJoinedByString:@"_"];
  return [NSString stringWithFormat:@"-[%@ %@]", specName, exampleName];
}

- (void)logException:(NSException *)exception {
  if(![exception filename]) {
    NSString *name = [exception name];
    NSString *reason = [exception reason];
    SPTSpec *spec = [[self class] SPT_spec];
    NSString *file = spec.fileName;
    NSString *description = [NSString stringWithFormat:@"%@: %@", name, reason];
    if([exception respondsToSelector:@selector(callStackSymbols)]) {
      NSArray *callStack = [exception callStackSymbols];
      if(callStack) {
        description = [NSString stringWithFormat:@"%@\n  Call Stack:\n    %@", description, [callStack componentsJoinedByString:@"\n    "]];
      }
    }
    NSString * sanitizedDescription = [description stringByReplacingOccurrencesOfString:@"%@" withString:@"?"];
    exception = [NSException exceptionWithName:name reason:description
                             userInfo:[[NSException failureInFile:file atLine:0 withDescription:sanitizedDescription] userInfo]];
  }
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
