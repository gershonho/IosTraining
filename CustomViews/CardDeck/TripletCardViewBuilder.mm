// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "TripletCardViewBuilder.h"
#import "TripletCard.h"
#import "TripletCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TripletCardViewBuilder


-(CardView *)buildCardViewFromCard:(Card *)card {
  TripletCardView *tripletCardView  = [[TripletCardView  alloc] init];
  TripletCard     *tripletCard      = (TripletCard      *)card;
  
  tripletCardView.number  = tripletCard.number;
  tripletCardView.symbol  = tripletCard.symbol;
  tripletCardView.filling = tripletCard.filling;
  tripletCardView.color   = tripletCard.color;
  tripletCardView.chosen  = tripletCard.chosen;

  return tripletCardView;
}

@end

NS_ASSUME_NONNULL_END
