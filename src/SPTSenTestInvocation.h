#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@interface SPTSenTestInvocation : NSInvocation

@property (nonatomic, copy) SPTVoidBlock SPT_invocationBlock;

@end
