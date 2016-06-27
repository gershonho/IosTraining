// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import <Foundation/Foundation.h>
#import "Card.h"
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardViewBuilder : NSObject
-(CardView *)buildCardViewFromCard:(Card *)card;
@end

NS_ASSUME_NONNULL_END
