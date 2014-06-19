#import "SPTXCTestCase.h"
#import "SPTSpec.h"
#import "SPTExample.h"
#import "SPTSharedExampleGroups.h"
#import "SpectaUtility.h"
#import <objc/runtime.h>
#import "XCTestPrivate.h"

@implementation SPTXCTestCase

+ (void)initialize {
  [SPTSharedExampleGroups initialize];
  SPTSpec *spec = [[SPTSpec alloc] init];
  SPTXCTestCase *testCase = [[[self class] alloc] init];
  objc_setAssociatedObject(self, "spt_spec", spec, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [testCase spt_defineSpec];
  [spec compile];
  [super initialize];
}

+ (SPTSpec *)spt_spec {
  return objc_getAssociatedObject(self, "spt_spec");
}

+ (BOOL)spt_isDisabled {
  return [self spt_spec].disabled;
}

+ (void)spt_setDisabled:(BOOL)disabled {
  [self spt_spec].disabled = disabled;
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
        if (SPTIsSpecClass(aClass)) {
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
    SPTSpec *spec = [specClass spt_spec];
    if (spec.disabled == NO && [spec hasFocusedExamples]) {
      return YES;
    }
  }

  return NO;
}

+ (SEL)spt_convertToTestMethod:(SPTExample *)example {
  @synchronized(example) {
    if (!example.testMethodSelector) {
      IMP imp = imp_implementationWithBlock(^(SPTXCTestCase *self) {
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

- (void)spt_setCurrentSpecWithFileName:(const char *)fileName lineNumber:(NSUInteger)lineNumber {
  SPTSpec *spec = [[self class] spt_spec];
  spec.fileName = @(fileName);
  spec.lineNumber = lineNumber;
  [[NSThread currentThread] threadDictionary][SPTCurrentSpecKey] = spec;
}

- (void)spt_defineSpec {}

- (void)spt_unsetCurrentSpec {
  [[[NSThread currentThread] threadDictionary] removeObjectForKey:SPTCurrentSpecKey];
}

- (void)spt_runExample:(SPTExample *)example {
  [[NSThread currentThread] threadDictionary][SPTCurrentTestCaseKey] = self;

  if (example.pending) {
    self.spt_pending = YES;
  } else {
    if ([[self class] spt_isDisabled] == NO &&
        (example.focused || [[self class] spt_focusedExamplesExist] == NO)) {
      ((SPTVoidBlock)example.block)();
    } else {
      self.spt_skipped = YES;
    }
  }

  [[[NSThread currentThread] threadDictionary] removeObjectForKey:SPTCurrentTestCaseKey];
}

#pragma mark - XCTestCase overrides

+ (NSArray *)testInvocations {
  NSArray *compiledExamples = [self spt_spec].compiledExamples;
  [NSMutableArray arrayWithCapacity:[compiledExamples count]];

  NSMutableSet *addedSelectors = [NSMutableSet setWithCapacity:[compiledExamples count]];
  NSMutableArray *selectors = [NSMutableArray arrayWithCapacity:[compiledExamples count]];

  // dynamically generate test methods with compiled examples
  for (SPTExample *example in compiledExamples) {
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


#ifdef _SPT_XCODE6
- (void)_recordUnexpectedFailureWithDescription:(NSString *)description exception:(NSException *)exception {
  id line = [exception userInfo][@"line"];
  id file = [exception userInfo][@"file"];
  if ([line isKindOfClass:[NSNumber class]] && [file isKindOfClass:[NSString class]]) {
    [self recordFailureWithDescription:description inFile:file atLine:[line unsignedIntegerValue] expected:YES];
  } else {
    [super _recordUnexpectedFailureWithDescription:description exception:exception];
  }
}
#endif

- (void)recordFailureWithDescription:(NSString *)description inFile:(NSString *)filename atLine:(NSUInteger)lineNumber expected:(BOOL)expected {
  SPTXCTestCase *currentTestCase = SPTCurrentTestCase;
#ifdef _SPT_XCODE6
  [currentTestCase.spt_run recordFailureWithDescription:description inFile:filename atLine:lineNumber expected:expected];
#else
  [currentTestCase.spt_run recordFailureInTest:currentTestCase withDescription:description inFile:filename atLine:lineNumber expected:expected];
#endif
}

- (void)performTest:(XCTestRun *)run {
  self.spt_run = (XCTestCaseRun *)run;
  [super performTest:run];
}

@end
