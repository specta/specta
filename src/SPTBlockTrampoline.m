//
//  SPTBlockTrampoline.m
//  Specta
//
//  Created by Josh Abernathy on 10/21/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import "SPTBlockTrampoline.h"

@interface SPTBlockTrampoline ()
@property (nonatomic, readonly, copy) id block;
@end

@implementation SPTBlockTrampoline

@synthesize block = _block;

#pragma mark API

- (id)initWithBlock:(id)block {
	self = [super init];
	if (self == nil) return nil;

	_block = [block copy];

	return self;
}

+ (void)invokeBlock:(id)block withArguments:(NSArray *)arguments {
	NSParameterAssert(block != NULL);

	SPTBlockTrampoline *trampoline = [[self alloc] initWithBlock:block];
	[trampoline invokeWithArguments:arguments];
}

- (void)invokeWithArguments:(NSArray *)arguments {
	SEL selector = [self selectorForArgumentCount:arguments.count];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
	invocation.selector = selector;
	invocation.target = self;

	for (NSUInteger i = 0; i < arguments.count; i++) {
		id arg = [arguments objectAtIndex:i];
		NSInteger argIndex = (NSInteger)(i + 2);
		[invocation setArgument:&arg atIndex:argIndex];
	}

	[invocation invoke];
}

- (SEL)selectorForArgumentCount:(NSUInteger)count {
	NSMutableString *selectorString = [NSMutableString stringWithString:@"performWith"];
	for (NSUInteger i = 0; i < count; i++) {
		[selectorString appendString:@":"];
	}

	SEL selector = NSSelectorFromString(selectorString);
	NSAssert([self respondsToSelector:selector], @"The argument count is too damn high! Only blocks of up to 15 arguments are currently supported.");
	return selector;
}

- (void)performWith {
	void (^block)(void) = self.block;
	block();
}

- (void)performWith:(id)obj1 {
	id (^block)(id) = self.block;
	block(obj1);
}

- (void)performWith:(id)obj1 :(id)obj2 {
	id (^block)(id, id) = self.block;
	block(obj1, obj2);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 {
	id (^block)(id, id, id) = self.block;
	block(obj1, obj2, obj3);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 {
	id (^block)(id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 {
	id (^block)(id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 {
	id (^block)(id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 {
	id (^block)(id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 {
	id (^block)(id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 {
	id (^block)(id, id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 {
	id (^block)(id, id, id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 {
	id (^block)(id, id, id, id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 {
	id (^block)(id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 :(id)obj13 {
	id (^block)(id, id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12, obj13);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 :(id)obj13 :(id)obj14 {
	id (^block)(id, id, id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12, obj13, obj14);
}

- (void)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 :(id)obj13 :(id)obj14 :(id)obj15 {
	id (^block)(id, id, id, id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
	block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12, obj13, obj14, obj15);
}

@end
