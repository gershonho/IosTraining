// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

// Deck of cards of any kind
// Empty on initialization
// Derived classes initialize it with cards of particular type

@interface Deck : NSObject

//Add a card either to the top or to the bottom
- (void)addCard:(Card *)card atTop:(BOOL)atTop;

//Return a card randomly drawn from the deck
- (Card*)drawRandomCard;
@end

NS_ASSUME_NONNULL_END
