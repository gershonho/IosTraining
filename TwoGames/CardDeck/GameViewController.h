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

- (void)updateCardButtonUI:(UIButton *)cardButton card:(Card *)card;
- (NSUInteger)cardCount;

@end

