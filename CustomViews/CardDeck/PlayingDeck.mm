// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "PlayingDeck.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingDeck

- (instancetype)init {
  self = [super init];
  
  if (self) {
    for (NSString *suit in [PlayingCard validSuits]) {
      //Valid Ranks are 1-13; rank 0 is invalid
      for (NSUInteger rank = 1; rank < [[PlayingCard rankStrings] count]; rank++) {
        PlayingCard* playingCard = [PlayingCard alloc];
        playingCard.rank = rank;
        playingCard.suit = suit;
        [self addCard:playingCard atTop:FALSE];
      }
    }
  }
  return self;
}


@end

NS_ASSUME_NONNULL_END
