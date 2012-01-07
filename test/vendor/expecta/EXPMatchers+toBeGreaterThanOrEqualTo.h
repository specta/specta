#import "Expecta.h"

EXPMatcherInterface(_toBeGreaterThanOrEqualTo, (id expected));
EXPMatcherInterface(toBeGreaterThanOrEqualTo, (id expected));

#define toBeGreaterThanOrEqualTo(expected) _toBeGreaterThanOrEqualTo(EXPObjectify((expected)))