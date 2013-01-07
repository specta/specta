#import <Foundation/Foundation.h>
#import "SPTExample.h"
#import "SpectaTypes.h"

@interface SPTAsyncExample : SPTExample {
	SPTAsyncBlock _asyncBlock;
}

@property (nonatomic, copy) SPTAsyncBlock asyncBlock;

- (id)initWithName:(NSString *)name asyncBlock:(SPTAsyncBlock)asyncBlock;

@end
