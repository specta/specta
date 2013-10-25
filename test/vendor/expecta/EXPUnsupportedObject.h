#import <Foundation/Foundation.h>

@interface EXPUnsupportedObject : NSObject

@property (nonatomic, retain) NSString *type;

- (id)initWithType:(NSString *)type;

@end
