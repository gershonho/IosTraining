//
//  TripletCardAttributeValue.h
//  CustomViews
//
//  Created by Gershon on 26/06/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#ifndef TripletCardAttributeValue_h
#define TripletCardAttributeValue_h



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

#endif /* TripletCardAttributeValue_h */
