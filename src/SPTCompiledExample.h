#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@interface SPTCompiledExample : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) SPTTestCaseBlock block;

@property (nonatomic) BOOL pending;
@property (nonatomic, getter=isFocused) BOOL focused;

@property (nonatomic) SEL testMethodSelector;

- (id)initWithName:(NSString *)name block:(SPTTestCaseBlock)block pending:(BOOL)pending focused:(BOOL)focused;
- (NSString *)underscoreName;

@end