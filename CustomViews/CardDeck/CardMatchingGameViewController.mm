// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "CardMatchingGameViewController.h"

#import "CardMatchingGame.h"
#import "PlayingDeck.h"
#import "PlayingCard.h"
#import "PlayingCardViewBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardMatchingGameViewController


- (NSUInteger)initialCardCount {
  return 20;
}

- (CGFloat)cellAspectRatio {
  return 0.66667;
}

- (BOOL) shouldRemoveMatchingCards {
  return NO;
}

- (BOOL) shouldFlipChosenCard {
  return YES;
}

- (Deck *)deck {
  if (super.deck == nil) {
    super.deck = [[PlayingDeck alloc] init];
  }
  
  return super.deck;
}

- (Game *)game {
  if (super.game == nil) {
    super.game = [[CardMatchingGame alloc] initWithCardCount:self.initialCardCount usingDeck:self.deck];
  }
  
  return super.game;
}

- (CardViewBuilder *)cardViewBuilder {
  if (super.cardViewBuilder == nil) {
    super.cardViewBuilder = [[PlayingCardViewBuilder alloc] init];
  }
  
  return super.cardViewBuilder;
}


@end

NS_ASSUME_NONNULL_END
