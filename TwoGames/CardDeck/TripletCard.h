// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN


//In the Set game each card has various properties (symbol, color etc.)
//Each of these properties has exactly 3 different values
//For simplicity we use a single enumeration for all properties
//In other words instead of having Red/Green/Blue colors and Triangle/Square/Circle symbols etc.
//we use One/Two/Three for all properties
typedef NS_ENUM(NSUInteger, TripletCardAttributeValue) {
  TripletCardAttributeValueNotSet,
  TripletCardAttributeValueMin,
  TripletCardAttributeValueOne = TripletCardAttributeValueMin,
  TripletCardAttributeValueTwo,
  TripletCardAttributeValueThree,
  TripletCardAttributeValueMax
};


@interface TripletCard : Card

///Symbol count on the card (1/2/3)
@property (nonatomic) TripletCardAttributeValue   number;

///Symbol on the card (Triangle/Square/Circle)
@property (nonatomic) TripletCardAttributeValue   symbol;

///Shading (Empty/Dashed/Full)
@property (nonatomic) TripletCardAttributeValue  shading;

///Color (Red/Green/Blue)
@property (nonatomic) TripletCardAttributeValue    color;

@end

NS_ASSUME_NONNULL_END
