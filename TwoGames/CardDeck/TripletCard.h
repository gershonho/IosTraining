// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, TripletCardAttributeValue) {
  TripletCardAttributeValueNotSet,
  TripletCardAttributeValueMin,
  TripletCardAttributeValueOne = TripletCardAttributeValueMin,
  TripletCardAttributeValueTwo,
  TripletCardAttributeValueThree,
  TripletCardAttributeValueMax
};


@interface TripletCard : Card


@property (nonatomic) TripletCardAttributeValue   number;
@property (nonatomic) TripletCardAttributeValue   symbol;
@property (nonatomic) TripletCardAttributeValue  shading;
@property (nonatomic) TripletCardAttributeValue    color;

@end

NS_ASSUME_NONNULL_END
