#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@interface SPTExample : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) id block;
@property (nonatomic) BOOL pending;
@property (nonatomic, getter = isFocused) BOOL focused;
@property (nonatomic) SEL testMethodSelector;

- (id)initWithName:(NSString *)name block:(id)block;
- (NSString *)underscoreName;

@end