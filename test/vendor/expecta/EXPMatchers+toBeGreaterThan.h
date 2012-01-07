#import "Expecta.h"

EXPMatcherInterface(_toBeGreaterThan, (id expected));
EXPMatcherInterface(toBeGreaterThan, (id expected));

#define toBeGreaterThan(expected) _toBeGreaterThan(EXPObjectify((expected)))