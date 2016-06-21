// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "CardMatchingGameViewController.h"

#import "CardMatchingGame.h"
#import "PlayingDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardMatchingGameViewController


- (Deck *)deck {
  if (super.deck == nil) {
    super.deck = [[PlayingDeck alloc] init];
  }
  
  return super.deck;
}

- (Game *)game {
  if (super.game == nil) {
    super.game = [[CardMatchingGame alloc] initWithCardCount:self.cardCount usingDeck:self.deck];
  }
  
  return super.game;
}

- (void)updateCardButtonUI:(UIButton *)cardButton card:(Card*)card {
  NSString *cardTitle = card.isChosen ? card.contents : @"";
  [cardButton setTitle:cardTitle forState:UIControlStateNormal];
  
  UIImage *image = [UIImage imageNamed:card.isChosen ? @"Blank Card" : @"Stanford"];
  [cardButton setBackgroundImage:image forState:UIControlStateNormal];
  
  cardButton.enabled = !card.isMatched;
  
}

@end

NS_ASSUME_NONNULL_END
