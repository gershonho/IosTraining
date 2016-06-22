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

///Current score in the game
@property(nonatomic, readonly)NSInteger score;

//Game history is a (growing) array of records.
//Each time a set of cards is choosen - a new record is pushed into history
//The record is a 2-members array
// - The first member is NSArray of the chosen cards
// - The second member is NSNumber containnithe score delta (points added/substracted)
@property(nonatomic, readonly)NSArray *history;


//These properties are game-specific. They must be overriden by the derived classes
@property(nonatomic, readonly)NSUInteger minCardsToChoose;
@property(nonatomic, readonly)NSUInteger maxCardsToChoose;


@end

NS_ASSUME_NONNULL_END
