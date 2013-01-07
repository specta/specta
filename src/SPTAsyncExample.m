//
//  SPTAsyncExample.m
//  Specta
//
//  Created by Dan Palmer on 06/01/2013.
//  Copyright (c) 2013 Peter Jihoon Kim. All rights reserved.
//

#import "SPTAsyncExample.h"

@implementation SPTAsyncExample

@synthesize asyncBlock=_asyncBlock;

- (void)dealloc {
	self.asyncBlock = nil;
	[super dealloc];
}

- (id)initWithName:(NSString *)name asyncBlock:(SPTAsyncBlock)asyncBlock {
	self = [super init];
	if (self) {
		self.name = name;
		self.asyncBlock = asyncBlock;
    self.pending = NO;
  }
  return self;
}

@end
