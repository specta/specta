#import <SenTestingKit/SenTestingKit.h>

@class SPTExampleGroup;

@interface SPTTestCase : SenTestCase

- (void)defineSpec;
+ (SPTExampleGroup *)rootGroup;
+ (NSMutableArray *)groupStack;
+ (SPTExampleGroup *)currentGroup;

@end

