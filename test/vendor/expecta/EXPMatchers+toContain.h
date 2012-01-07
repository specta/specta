#import "Expecta.h"

EXPMatcherInterface(_toContain, (id expected));
EXPMatcherInterface(toContain, (id expected)); // to aid code completion
#define toContain(expected) _toContain(EXPObjectify((expected)))
