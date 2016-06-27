// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "PlayingCardViewBuilder.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardViewBuilder


-(CardView *)buildCardViewFromCard:(Card *)card {
  PlayingCardView *playingCardView  = [[PlayingCardView  alloc] init];
  PlayingCard     *playingCard      = (PlayingCard      *)card;
  
  playingCardView.suit = [NSString stringWithString:playingCard.suit];
  playingCardView.rank = playingCard.rank;
  playingCardView.faceUp = playingCard.chosen || playingCard.matched;
  playingCardView.disabled = playingCard.matched;
  
  return playingCardView;
}

@end

NS_ASSUME_NONNULL_END
