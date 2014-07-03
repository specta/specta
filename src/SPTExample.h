#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@interface SPTExample : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) SPTVoidBlock block;

@property (nonatomic) BOOL pending;
@property (nonatomic, getter=isFocused) BOOL focused;

- (id)initWithName:(NSString *)name block:(SPTVoidBlock)block;

@end