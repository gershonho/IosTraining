// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "CardMatchingGameViewController.h"

#import "CardMatchingGame.h"
#import "PlayingDeck.h"
#import "PlayingCard.h"

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
  if (card.isChosen) {
    [cardButton setAttributedTitle:[self attributedTitleForCard:card]
                          forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[UIImage imageNamed:@"Blank Card"]
                          forState:UIControlStateNormal];
  } else {
    [cardButton setAttributedTitle:[[NSAttributedString alloc] init]
                          forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[UIImage imageNamed:@"Stanford"]
                          forState:UIControlStateNormal];
  }
  
  cardButton.enabled = !card.isMatched;
  
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card {
  PlayingCard *playingCard = (PlayingCard *)card;
  
  NSString *suit = playingCard.suit;
  NSUInteger rank = playingCard.rank;
  
  //Start with the rank string
  NSString *rankString = [[PlayingCard rankStrings] objectAtIndex:rank];
  NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc]
      initWithString:rankString];

  //Add the suite with appropriate color
  UIColor *color = (([suit isEqualToString:@"♠︎"] ||  [suit isEqualToString:@"♣︎"])) ?
      [UIColor blackColor] : [UIColor redColor];
  NSAttributedString *suiteString = [[NSAttributedString alloc] initWithString:suit attributes:@{NSForegroundColorAttributeName:color}];
  [attributedTitle appendAttributedString:suiteString];
  
  return attributedTitle;
}

@end

NS_ASSUME_NONNULL_END
