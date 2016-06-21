// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly)NSInteger score;


//This is a protected property. Derived classes must override it
@property(nonatomic, readonly)NSUInteger maxCardsToChoose;


@end

NS_ASSUME_NONNULL_END
