// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCard


static const NSUInteger kPointsForMatchingSuit = 1;
static const NSUInteger kPointsForMatchingRank = 4;

//Class variables - valid rank strings & suits
+ (NSArray *)rankStrings {
  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *)validSuits {
  return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

//Contents - contcatenates rank string & suit
- (NSString *)contents {
  NSArray *rankStrings = [PlayingCard rankStrings];
  return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

//Suit setter & getter
@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
  NSArray *validSuits = [PlayingCard validSuits];
  if ([validSuits containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *)suit {
  return _suit ? _suit : @"?";
}

//Rank setter & getter
@synthesize rank = _rank;

- (void)setRank:(NSUInteger)rank {
  NSUInteger maximalRank = [[PlayingCard rankStrings] count];
  if (rank < maximalRank) {
    _rank = rank;
  }
}

- (NSUInteger)rank {
  return _rank;
}

//Match - the sum of scores with all Other Cards
+ (int)match:(NSArray *)cards {
  int score = 0;
  if (cards.count != 2) {
    return score;
  }
  
  PlayingCard* firstCard = cards.firstObject;
  PlayingCard* lastCard = cards.lastObject;
  
  if ([firstCard.suit isEqualToString:lastCard.suit]) {
    score = kPointsForMatchingSuit;
  } else if (firstCard.rank == lastCard.rank) {
    score = kPointsForMatchingRank;
  }
  
  return score;
}


@end

NS_ASSUME_NONNULL_END
