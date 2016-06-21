// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game()
@property(nonatomic, readwrite)NSInteger score;
@property(nonatomic, strong)NSMutableArray *cards;

@end

@implementation Game

static const NSUInteger kMatchingBonus = 4;
static const NSUInteger kMismatchPenalty = 1;
static const NSUInteger kCostToChoose = 1;

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger) count
                        usingDeck:(Deck *)deck
{
  self = [super init];
  if (self) {
    for (int i = 0; i < count; i++) {
      Card *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  return self;
}

- (instancetype)init {
  return nil;
}

- (NSUInteger) maxCardsToChoose {
  return 0;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  
  Card *card = [self cardAtIndex:index];
  
  if (card == nil) {
    return;
  }
  
  if (card.isMatched) {
    return;
  }
  
  //Flip the card's "chosen" property
  card.chosen = !card.chosen;
  
  if (card.isChosen) {
     NSMutableArray *chosenCards = [[NSMutableArray alloc] initWithCapacity:self.maxCardsToChoose];
    
    for (Card *anyCard in self.cards) {
      if (anyCard.isMatched) {
        continue;
      }
      if (!anyCard.isChosen) {
        continue;
      }
      
      [chosenCards addObject:anyCard];
    }
    
    if (chosenCards.count > 1) {
      int matchScore = [card.class match:chosenCards];
      if (matchScore) {
        self.score += matchScore * kMatchingBonus;
        for (Card *anyCard in chosenCards) {
          anyCard.matched = YES;
        }
      } else {
        self.score -= kMismatchPenalty;
        if (chosenCards.count >= self.maxCardsToChoose) {
          for (Card *anyCard in chosenCards) {
            if (anyCard != card) {
              anyCard.chosen = NO;
            }
          }
        }
      }
    }
  }
  self.score -= kCostToChoose;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < self.cards.count) ? self.cards[index] : nil;
}




@end

NS_ASSUME_NONNULL_END
