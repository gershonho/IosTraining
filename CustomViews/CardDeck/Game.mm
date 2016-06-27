// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game()
@property(nonatomic, readwrite)NSInteger score;
@property(nonatomic, strong)NSMutableArray *cards;
@end

@implementation Game

//static const NSUInteger kCostToChoose = 1;


static const NSUInteger kMatchingBonus = 4;
static const NSUInteger kPenaltyForMismatch = 1;
static const NSUInteger kPenaltyForDealMore = 1;


- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (NSUInteger) cardCount {
  return self.cards.count;
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
    NSMutableArray *chosenCards = [[NSMutableArray alloc] initWithCapacity:self.cardsToChoose];
    
    for (Card *anyCard in self.cards) {
      if (anyCard.isMatched) {
        continue;
      }
      if (!anyCard.isChosen) {
        continue;
      }
      
      [chosenCards addObject:anyCard];
    }
    
    if (chosenCards.count == self.cardsToChoose) {
      
      NSInteger scoreDelta = 0;
      
      //Check if we have a match
      int matchScore = [card.class match:chosenCards];
      if (matchScore) {
        scoreDelta = matchScore * kMatchingBonus;
        for (Card *anyCard in chosenCards) {
          anyCard.matched = YES;
        }
      } else {
        scoreDelta = -kPenaltyForMismatch;
        for (Card *anyCard in chosenCards) {
          if (anyCard != card) {
            anyCard.chosen = NO;
          }
        }
      }
      
      //Update the score
      self.score += scoreDelta;
    }
  }
  //self.score -= kCostToChoose;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)removeCardAtIndex:(NSUInteger)index {
  if (self.shouldRemoveMatchingCards) {
    [self.cards removeObjectAtIndex:index];
  }
}

///Draw some cards from a desk, add them to the game
- (NSUInteger)drawCardsFromDesk:(NSUInteger)count usingDeck:(Deck *)deck {
  for (int i = 0; i < count; i++) {
    Card *card = [deck drawRandomCard];
    if (card) {
      [self.cards addObject:card];
    } else {
      return i;
    }
  }
  
  self.score -= kPenaltyForDealMore * self.cards.count;
  return count;
}



@end

NS_ASSUME_NONNULL_END
