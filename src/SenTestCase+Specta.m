#import "SenTestCase+Specta.h"
#import "SPTSenTestCase.h"

@implementation SenTestCase (Specta)

+ (BOOL)SPT_isProjectDirectoryPath:(NSString *)projectDirectoryPath
{
  NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:projectDirectoryPath
                                                                                    error:NULL];
  if ([directoryContents count] > 0)
  {
    for (NSString * filename in directoryContents)
    {
      if ([[filename pathExtension] isEqualToString:@"xcodeproj"])
      {
        return YES;
      }
    }
  }
  
  return NO;
}

+ (NSString *)SPT_projectDirectory
{
  NSString * currentDirectory = [[NSFileManager defaultManager] currentDirectoryPath];
  NSString * projectDirectory = currentDirectory;
  while (projectDirectory != nil
         && [projectDirectory length] > 0
         && [self SPT_isProjectDirectoryPath:projectDirectory] == NO)
  {
    projectDirectory = [projectDirectory stringByDeletingLastPathComponent];
  }
  
  if ([projectDirectory length] > 0)
  {
    return projectDirectory;
  }
  else
  {
    return currentDirectory;
  }
}

+ (NSString *)SPT_testCasePathname
{
  NSString * expectedFileName = [NSString stringWithFormat:@"%@.m", NSStringFromClass(self)];
  
  NSString * projectDirectory = [self SPT_projectDirectory];
  if (projectDirectory != nil)
  {
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:projectDirectory];
    
    NSString * currentFile = [enumerator nextObject];
    while (currentFile != nil)
    {
      NSString * filename = [currentFile lastPathComponent];
      if ([filename isEqualToString:expectedFileName])
      {
        return [projectDirectory stringByAppendingPathComponent:currentFile];
      }
      else if ([filename isEqualToString:@".git"]
               || [[filename pathExtension] isEqualToString:@".xcodeproj"])
      {
        [enumerator skipDescendants];
      }
      
      currentFile = [enumerator nextObject];
    }
    
    return [projectDirectory stringByAppendingPathComponent:expectedFileName];
  }
  else
  {
    return expectedFileName;
  }
}

- (NSString *)SPT_title
{
  if ([self isKindOfClass:[SPTSenTestCase class]])
  {
    SPTExample * example = [(SPTSenTestCase *)self SPT_getCurrentExample];
    return [example name];
  }
  else
  {
    return NSStringFromSelector([self selector]);
  }
}

@end
