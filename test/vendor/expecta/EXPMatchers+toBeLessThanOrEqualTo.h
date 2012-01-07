#import "Expecta.h"

EXPMatcherInterface(_toBeLessThanOrEqualTo, (id expected));
EXPMatcherInterface(toBeLessThanOrEqualTo, (id expected));

#define toBeLessThanOrEqualTo(expected) _toBeLessThanOrEqualTo(EXPObjectify((expected)))