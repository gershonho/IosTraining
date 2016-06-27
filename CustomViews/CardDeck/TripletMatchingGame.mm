// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "TripletMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TripletMatchingGame

- (NSUInteger) cardsToChoose {
  return 3;
}

- (BOOL) shouldRemoveMatchingCards {
  return YES;
}

@end

NS_ASSUME_NONNULL_END
