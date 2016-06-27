// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "CardView.h"
#import "TripletCardAttributeValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripletCardView : CardView


///Symbol count on the card (1/2/3)
@property (nonatomic) TripletCardAttributeValue   number;

///Symbol on the card (Squiggle/Diamond/Oval)
@property (nonatomic) TripletCardAttributeValue   symbol;

///Filling (Unfilled/Stripped/Solid)
@property (nonatomic) TripletCardAttributeValue  filling;

///Color (Green/Red/Purple)
@property (nonatomic) TripletCardAttributeValue    color;

//IsChosen
@property (nonatomic, getter=isChosen) BOOL chosen;
@end

NS_ASSUME_NONNULL_END
