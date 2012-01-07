#import "Expecta.h"

EXPMatcherInterface(_toEqual, (id expected));
EXPMatcherInterface(toEqual, (id expected)); // to aid code completion
#define toEqual(expected) _toEqual(EXPObjectify((expected)))
