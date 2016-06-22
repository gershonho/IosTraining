// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game()
@property(nonatomic, readwrite)NSInteger score;
@property(nonatomic, strong)NSMutableArray *cards;
@property(nonatomic)NSMutableArray *mutableHistory;
@end

@implementation Game

//static const NSUInteger kCostToChoose = 1;


static const NSUInteger kMatchingBonus = 4;
static const NSUInteger kMismatchPenalty = 1;


- (NSInteger) matchingBonus {
  return 4;
}

- (NSInteger) mismatchPenalty {
  return 1;
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (NSMutableArray *)mutableHistory {
  if (!_mutableHistory) {
    _mutableHistory = [[NSMutableArray alloc] init];
  }
  return _mutableHistory;
}

@synthesize history;

- (NSArray *)history {
  return self.mutableHistory;
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
    
    if (chosenCards.count >= self.minCardsToChoose) {
      
      NSInteger scoreDelta = 0;

      //Check if we have a match
      int matchScore = [card.class match:chosenCards];
      if (matchScore) {
        scoreDelta = matchScore * kMatchingBonus;
        for (Card *anyCard in chosenCards) {
          anyCard.matched = YES;
        }
      } else {
        scoreDelta = -kMismatchPenalty;
        if (chosenCards.count >= self.maxCardsToChoose) {
          for (Card *anyCard in chosenCards) {
            if (anyCard != card) {
              anyCard.chosen = NO;
            }
          }
        }
      }
      
      //Update the score
      self.score += scoreDelta;

      //Create the new history record. It contains the chosen card set and score delta
      NSArray *historyRecord = @[chosenCards, [NSNumber numberWithLong:scoreDelta]];
      
      //Update the history
      [self.mutableHistory addObject:historyRecord];
    }
  }
  //self.score -= kCostToChoose;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < self.cards.count) ? self.cards[index] : nil;
}




@end

NS_ASSUME_NONNULL_END
