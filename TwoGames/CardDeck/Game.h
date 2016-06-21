// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly)NSInteger matchingBonus;
@property(nonatomic, readonly)NSInteger mismatchPenalty;

//Current score in the game
@property(nonatomic, readonly)NSInteger score;

//History is array of arrays of cards
//Each time a card is chosen - the array of all currently chosen cards
//is pushed to history
@property(nonatomic, readonly)NSArray *history;


//This property must be overriden by the derived classes
@property(nonatomic, readonly)NSUInteger maxCardsToChoose;


@end

NS_ASSUME_NONNULL_END
