#import <Foundation/Foundation.h>

#define SPT_isBlock(obj) [(obj) isKindOfClass:NSClassFromString(@"NSBlock")]

const char *SPT_getBlockSignature(id blockObject);
BOOL SPT_IsSpecClass(Class aClass);