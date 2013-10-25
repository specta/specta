#import <Foundation/Foundation.h>

@interface EXPUnsupportedObject : NSObject

@property (nonatomic, strong) NSString *type;

- (id)initWithType:(NSString *)type;

@end
