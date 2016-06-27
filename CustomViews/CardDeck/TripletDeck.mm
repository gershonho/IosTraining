// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "TripletDeck.h"
#import "TripletCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TripletDeck


- (instancetype)init {
  self = [super init];
  
  if (self) {
    for (NSUInteger number = TripletCardAttributeValueMin; number < TripletCardAttributeValueMax; number++) {
      for (NSUInteger symbol = TripletCardAttributeValueMin; symbol < TripletCardAttributeValueMax; symbol++) {
        for (NSUInteger filling = TripletCardAttributeValueMin; filling < TripletCardAttributeValueMax; filling++) {
          for (NSUInteger color = TripletCardAttributeValueMin; color < TripletCardAttributeValueMax; color++) {
            
            TripletCard* tripletCard = [[TripletCard alloc] init];
            tripletCard.number  = (TripletCardAttributeValue)number;
            tripletCard.symbol  = (TripletCardAttributeValue)symbol;
            tripletCard.filling = (TripletCardAttributeValue)filling;
            tripletCard.color   = (TripletCardAttributeValue)color;
            
            [self addCard:tripletCard atTop:FALSE];
          }
        }
      }
    }
    
    
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
