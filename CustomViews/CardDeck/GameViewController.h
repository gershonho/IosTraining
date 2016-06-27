//
//  ViewController.h
//  CardDeck
//
//  Created by Gershon on 16/06/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Deck.h"
#import "Game.h"
#import "CardViewBuilder.h"

@interface GameViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) Game *game;


//To be overriden by derived classes
@property (strong, nonatomic) CardViewBuilder *cardViewBuilder;
@property (readonly, nonatomic) NSUInteger initialCardCount;
@property (readonly, nonatomic) CGFloat cellAspectRatio;
@property (readonly, nonatomic) BOOL shouldRemoveMatchingCards;
@property (readonly, nonatomic) BOOL shouldFlipChosenCard;


@end

