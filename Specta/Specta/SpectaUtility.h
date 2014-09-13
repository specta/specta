#import <Foundation/Foundation.h>

extern NSString * const SPTCurrentTestSuiteKey;
extern NSString * const SPTCurrentSpecKey;

#define SPTCurrentTestSuite [[NSThread currentThread] threadDictionary][SPTCurrentTestSuiteKey]
#define SPTCurrentSpec  [[NSThread currentThread] threadDictionary][SPTCurrentSpecKey]
#define SPTCurrentGroup     [SPTCurrentTestSuite currentGroup]
#define SPTGroupStack       [SPTCurrentTestSuite groupStack]

#define SPTReturnUnlessBlockOrNil(block) if ((block) && !SPTIsBlock((block))) return;
#define SPTIsBlock(obj) [(obj) isKindOfClass:NSClassFromString(@"NSBlock")]

BOOL spt_isSpecClass(Class aClass);
NSString *spt_underscorize(NSString *string);
NSArray *spt_map(NSArray *array, id (^block)(id obj, NSUInteger idx));