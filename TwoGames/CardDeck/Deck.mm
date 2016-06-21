// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation Deck

- (instancetype)init {
    self = [super init];
    if (self) {
      _cards = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  } else {
    [self.cards addObject:card];
  }
}

- (Card*)drawRandomCard {
  Card *randomCard = nil;
  
  unsigned index = arc4random() % [self.cards count];
  randomCard = self.cards[index];
  [self.cards removeObjectAtIndex:index];
  
  return randomCard;
  
}
@end

NS_ASSUME_NONNULL_END
