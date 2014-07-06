#import "SPTSpec.h"
#import "SPTTestSuite.h"
#import "SPTCompiledExample.h"
#import "SPTSharedExampleGroups.h"
#import "SpectaUtility.h"
#import <objc/runtime.h>
#import "XCTest+Private.h"


@implementation SPTSpec

+ (void)initialize {
  [SPTSharedExampleGroups initialize];
  SPTTestSuite *testSuite = [[SPTTestSuite alloc] init];
  SPTSpec *spec = [[[self class] alloc] init];
  objc_setAssociatedObject(self, "spt_testSuite", testSuite, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [spec spec];
  [testSuite compile];
  [super initialize];
}

+ (SPTTestSuite *)spt_testSuite {
  return objc_getAssociatedObject(self, "spt_testSuite");
}

+ (BOOL)spt_isDisabled {
  return [self spt_testSuite].disabled;
}

+ (void)spt_setDisabled:(BOOL)disabled {
  [self spt_testSuite].disabled = disabled;
}

+ (NSArray *)spt_allSpecClasses {
  static NSArray *allSpecClasses = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{

    NSMutableArray *specClasses = [[NSMutableArray alloc] init];

    int numberOfClasses = objc_getClassList(NULL, 0);
    if (numberOfClasses > 0) {
      Class *classes = (Class *)malloc(sizeof(Class) * numberOfClasses);
      numberOfClasses = objc_getClassList(classes, numberOfClasses);

      for (int classIndex = 0; classIndex < numberOfClasses; classIndex++) {
        Class aClass = classes[classIndex];
        if (spt_isTestCaseClass(aClass)) {
          [specClasses addObject:aClass];
        }
      }

      free(classes);
    }

    allSpecClasses = [specClasses copy];
  });

  return allSpecClasses;
}

+ (BOOL)spt_focusedExamplesExist {
  for (Class specClass in [self spt_allSpecClasses]) {
    SPTTestSuite *testSuite = [specClass spt_testSuite];
    if (testSuite.disabled == NO && [testSuite hasFocusedExamples]) {
      return YES;
    }
  }

  return NO;
}

+ (SEL)spt_convertToTestMethod:(SPTCompiledExample *)example {
  @synchronized(example) {
    if (!example.testMethodSelector) {
      IMP imp = imp_implementationWithBlock(^(SPTSpec *self) {
        [self spt_runExample:example];
      });

      SEL sel;
      unsigned int i = 0;

      do {
        i++;
        if (i == 1) {
          sel = NSSelectorFromString([NSString stringWithFormat:@"test_%@", example.underscoreName]);
        } else {
          sel = NSSelectorFromString([NSString stringWithFormat:@"test_%@_%u", example.underscoreName, i]);
        }
      } while([self instancesRespondToSelector:sel]);

      class_addMethod(self, sel, imp, "@@:");
      example.testMethodSelector = sel;
    }
  }

  return example.testMethodSelector;
}

- (void)spt_setCurrentTestSuiteWithFileName:(const char *)fileName lineNumber:(NSUInteger)lineNumber {
  SPTTestSuite *testSuite = [[self class] spt_testSuite];
  testSuite.fileName = @(fileName);
  testSuite.lineNumber = lineNumber;
  [[NSThread currentThread] threadDictionary][SPTCurrentTestSuiteKey] = testSuite;
}

- (void)spec {}

- (void)spt_unsetCurrentTestSuite {
  [[[NSThread currentThread] threadDictionary] removeObjectForKey:SPTCurrentTestSuiteKey];
}

- (void)spt_runExample:(SPTCompiledExample *)example {
  [[NSThread currentThread] threadDictionary][SPTCurrentSpecKey] = self;

  if (example.pending) {
    self.spt_pending = YES;
  } else {
    if ([[self class] spt_isDisabled] == NO &&
        (example.focused || [[self class] spt_focusedExamplesExist] == NO)) {
      example.block(self);
    } else {
      self.spt_skipped = YES;
    }
  }

  [[[NSThread currentThread] threadDictionary] removeObjectForKey:SPTCurrentSpecKey];
}

#pragma mark - XCTestCase overrides

+ (NSArray *)testInvocations {
  NSArray *compiledExamples = [self spt_testSuite].compiledExamples;
  [NSMutableArray arrayWithCapacity:[compiledExamples count]];

  NSMutableSet *addedSelectors = [NSMutableSet setWithCapacity:[compiledExamples count]];
  NSMutableArray *selectors = [NSMutableArray arrayWithCapacity:[compiledExamples count]];

  // dynamically generate test methods with compiled examples
  for (SPTCompiledExample *example in compiledExamples) {
    SEL sel = [self spt_convertToTestMethod:example];
    NSString *selName = NSStringFromSelector(sel);
    [selectors addObject: selName];
    [addedSelectors addObject: selName];
  }

  // look for any other test methods that may be present in class.
  unsigned int n;
  Method *imethods = class_copyMethodList(self, &n);
  
  for (NSUInteger i = 0; i < n; i++) {
    struct objc_method_description *desc = method_getDescription(imethods[i]);

    char *types = desc->types;
    SEL sel = desc->name;
    NSString *selName = NSStringFromSelector(sel);

    if (strcmp(types, "@@:") == 0 && [selName hasPrefix:@"test"] && ![addedSelectors containsObject:selName]) {
      [selectors addObject:NSStringFromSelector(sel)];
    }
  }

  free(imethods);

  // create invocations from test method selectors
  NSMutableArray *invocations = [NSMutableArray arrayWithCapacity:[selectors count]];
  for (NSString *selName in selectors) {
    SEL sel = NSSelectorFromString(selName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:sel]];
    [inv setSelector:sel];
    [invocations addObject:inv];
  }

  return invocations;
}

- (void)recordFailureWithDescription:(NSString *)description inFile:(NSString *)filename atLine:(NSUInteger)lineNumber expected:(BOOL)expected {
  SPTSpec *currentSpec = SPTCurrentSpec;
  [currentSpec.spt_run recordFailureWithDescription:description inFile:filename atLine:lineNumber expected:expected];
}

- (void)performTest:(XCTestRun *)run {
  self.spt_run = (XCTestCaseRun *)run;
  [super performTest:run];
}

@end
