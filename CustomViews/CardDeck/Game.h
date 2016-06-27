// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

//Abstract game

@interface Game : NSObject

///Initialize the game by randomly drawing some cards from a deck
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

///Chose a card at index
- (void)chooseCardAtIndex:(NSUInteger)index;

///Return a card at index (no choosing)
- (Card *)cardAtIndex:(NSUInteger)index;

///Remove a card at index
- (void)removeCardAtIndex:(NSUInteger)index;

///Draw some cards from a desk, add them to the game
- (NSUInteger)drawCardsFromDesk:(NSUInteger)count usingDeck:(Deck *)deck;

///Current score in the game
@property(nonatomic, readonly)NSInteger score;

///Current card count
@property(nonatomic, readonly)NSUInteger cardCount;

//These properties are game-specific. They must be overriden by the derived classes
@property(nonatomic, readonly)NSUInteger cardsToChoose;
@property (readonly, nonatomic) BOOL shouldRemoveMatchingCards;

@end

NS_ASSUME_NONNULL_END
