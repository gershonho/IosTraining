// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN


@implementation CardMatchingGame

- (NSUInteger) cardsToChoose {
  return 2;
}

- (BOOL) shouldRemoveMatchingCards {
  return NO;
}

@end

NS_ASSUME_NONNULL_END
