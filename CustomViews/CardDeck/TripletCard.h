// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Card.h"
#import "TripletCardAttributeValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripletCard : Card

///Symbol count on the card (1/2/3)
@property (nonatomic) TripletCardAttributeValue   number;

///Symbol on the card (Squiggle/Diamond/Oval)
@property (nonatomic) TripletCardAttributeValue   symbol;

///Filling (Unfilled/Stripped/Solid)
@property (nonatomic) TripletCardAttributeValue  filling;

///Color (Green/Red/Purple)
@property (nonatomic) TripletCardAttributeValue    color;

@end

NS_ASSUME_NONNULL_END
