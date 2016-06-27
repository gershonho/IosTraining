// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Card

//To prevent using this class without overriding we throw an exception
+ (int)match:(NSArray *)cards {
  throw [NSException exceptionWithName:NSInternalInconsistencyException
                                reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                              userInfo:nil];
    return 0;
}

@end

NS_ASSUME_NONNULL_END
