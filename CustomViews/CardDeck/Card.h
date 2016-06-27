// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//Abstract class for a card

@interface Card : NSObject


//Flag to be set once the card is chosen
@property (nonatomic, getter=isChosen) BOOL chosen;

//Flag to be set once the card is matched
@property (nonatomic, getter=isMatched) BOOL matched;

//Match score of a set of card
// 0 when the cards are not matching
// >0 when the cards are matching
+ (int)match:(NSArray *)cards;

@end

NS_ASSUME_NONNULL_END
