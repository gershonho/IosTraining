// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "TripletMatchingGameViewController.h"

#import "TripletMatchingGame.h"
#import "TripletDeck.h"
#import "TripletCard.h"
#import "TripletCardViewBuilder.h"

NS_ASSUME_NONNULL_BEGIN


@implementation TripletMatchingGameViewController


- (NSUInteger)initialCardCount {
  return 12;
}

- (CGFloat)cellAspectRatio {
  return 1.5;
}

- (BOOL) shouldRemoveMatchingCards {
  return YES;
}

- (BOOL) shouldFlipChosenCard {
  return NO;
}

- (Deck *)deck {
  if (super.deck == nil) {
    super.deck = [[TripletDeck alloc] init];
  }
  
  return super.deck;
}

- (Game *)game {
  if (super.game == nil) {
    super.game = [[TripletMatchingGame alloc] initWithCardCount:self.initialCardCount usingDeck:self.deck];
  }
  
  return super.game;
}

- (CardViewBuilder *)cardViewBuilder {
  if (super.cardViewBuilder == nil) {
    super.cardViewBuilder = [[TripletCardViewBuilder alloc] init];
  }
  
  return super.cardViewBuilder;
}


@end

NS_ASSUME_NONNULL_END
