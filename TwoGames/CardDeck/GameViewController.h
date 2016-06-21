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

@interface GameViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) Game *game;

- (NSUInteger)cardCount;

//These methods must be overriden by derived classes

//Update the UI of a card button with the data from the Card object
- (void)updateCardButtonUI:(UIButton *)cardButton card:(Card *)card;

//Given a card produce its Attributed Title
- (NSAttributedString *)attributedTitleForCard:(Card *)card;
@end

