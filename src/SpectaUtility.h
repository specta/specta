#import <Foundation/Foundation.h>
extern NSString * const SPTCurrentTestSuiteKey;
extern NSString * const SPTCurrentTestCaseKey;

#define SPTCurrentTestSuite [[NSThread currentThread] threadDictionary][SPTCurrentTestSuiteKey]
#define SPTCurrentTestCase  [[NSThread currentThread] threadDictionary][SPTCurrentTestCaseKey]
#define SPTCurrentGroup     [SPTCurrentTestSuite currentGroup]
#define SPTGroupStack       [SPTCurrentTestSuite groupStack]

#define SPTReturnUnlessBlockOrNil(block) if ((block) && !SPTIsBlock((block))) return;
#define SPTIsBlock(obj) [(obj) isKindOfClass:NSClassFromString(@"NSBlock")]

BOOL spt_isTestCaseClass(Class aClass);