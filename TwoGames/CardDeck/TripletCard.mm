// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "TripletCard.h"

NS_ASSUME_NONNULL_BEGIN

static const NSUInteger kCardsInTriplet = 3;
static const NSUInteger kPointsForMatching = 10;

typedef NS_ENUM(NSUInteger, TripletCardAttributeName) {
  TripletCardAttributeNameMin,
  TripletCardAttributeNameNumber = TripletCardAttributeNameMin,
  TripletCardAttributeNameSymbol,
  TripletCardAttributeNameShading,
  TripletCardAttributeNameColor,
  TripletCardAttributeNameMax
};

@implementation TripletCard


- (void)setNumber:(TripletCardAttributeValue)number {
  if (number < TripletCardAttributeValueMax) {
    _number = number;
  }
}

- (void)setSymbol:(TripletCardAttributeValue)symbol {
  if (symbol < TripletCardAttributeValueMax) {
    _symbol = symbol;
  }
}

- (void)setShading:(TripletCardAttributeValue)shading {
  if (shading < TripletCardAttributeValueMax) {
    _shading = shading;
  }
}

- (void)setColor:(TripletCardAttributeValue)color {
  if (color < TripletCardAttributeValueMax) {
    _color = color;
  }
}

- (TripletCardAttributeValue)getAttributeByName:(TripletCardAttributeName)attributeName {
  switch (attributeName) {
    case TripletCardAttributeNameNumber:
      return self.number;
    case TripletCardAttributeNameSymbol:
      return self.symbol;
    case TripletCardAttributeNameShading:
      return self.shading;
    case TripletCardAttributeNameColor:
      return self.color;
    default:
      return TripletCardAttributeValueNotSet;
  }
}

+ (int)match:(NSArray *)cards {
  int score = 0;
  
  if ([TripletCard isTripletMatching:cards]) {
    score = kPointsForMatching;
  }
  
  return score;
}

+ (BOOL) isTripletMatching:(NSArray *)triplet {
  //For a triplet to be a match it must match w.r.t. all its attributes (number, symbol, shading, color)
  return
  [TripletCard isTripletMatchingWithRespectToAttribute:triplet attributeName:TripletCardAttributeNameNumber] &&
  [TripletCard isTripletMatchingWithRespectToAttribute:triplet attributeName:TripletCardAttributeNameSymbol] &&
  [TripletCard isTripletMatchingWithRespectToAttribute:triplet attributeName:TripletCardAttributeNameShading] &&
  [TripletCard isTripletMatchingWithRespectToAttribute:triplet attributeName:TripletCardAttributeNameColor];
}

+ (BOOL) isTripletMatchingWithRespectToAttribute:(NSArray *)triplet attributeName:(TripletCardAttributeName)attributeName {
  
  //Check if we got exactly 3 cards
  if (triplet.count != kCardsInTriplet) {
    return NO;
  }
  
  //A triplet is matching w.r.t. some attribute iff this attribute is the same for all cards in the triplet
  // or it is different for all of them
  
  //Check if all values are the same
  NSUInteger firstValue = [triplet[0] getAttributeByName:attributeName];
  BOOL allValuesAreSame = YES;
  
  //Go through all values except the first
  for (NSUInteger cardIndex = 1; cardIndex < kCardsInTriplet; cardIndex++) {
    NSUInteger value = [triplet[cardIndex] getAttributeByName:attributeName];
    if (value != firstValue) {
      allValuesAreSame = NO;
      break;
    }
  }
  
  if (allValuesAreSame) {
    return YES;
  }
  
  //Check if all values are different
  
  //Boolean array that will store "YES" for each value used by a card.
  //Initialize by NO's
  BOOL valueIsPresent[kCardsInTriplet] = {NO};
  
  //Go through all cards. Set the array element for "YES" for any used value
  for (NSUInteger cardIndex = 0; cardIndex < kCardsInTriplet; cardIndex++) {
    NSUInteger value = [triplet[cardIndex] getAttributeByName:attributeName];
    valueIsPresent[value - TripletCardAttributeValueMin] = YES;
  }
  
  //Verify that the array is all YES's. This would mean all values are present.
  BOOL allValuesArePresent = YES;
  for (NSUInteger cardIndex = 0; cardIndex < kCardsInTriplet; cardIndex++) {
    if (!valueIsPresent[cardIndex]) {
      allValuesArePresent = NO;
      break;
    }
  }
  
  return allValuesArePresent ? YES : NO;
}

@end

NS_ASSUME_NONNULL_END
