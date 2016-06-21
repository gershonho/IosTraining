//
//  ViewController.m
//  CardDeck
//
//  Created by Gershon on 16/06/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "GameViewController.h"

extern const NSUInteger kMatchingBonus;
extern const NSUInteger kMismatchPenalty;

@interface GameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchUnmatchLabel;

@end

@implementation GameViewController

- (void) viewDidLoad {
  [super viewDidLoad];
  [self updateUI];
}

- (IBAction)onButtonClicked:(UIButton *)sender {
  NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];
}
- (IBAction)onRedeal:(id)sender {
  self.deck = nil;
  self.game = nil;
  [self updateUI];
}

- (NSUInteger)cardCount {
  return [self.cardButtons count];
}

- (void)updateUI {
  for (int cardIndex = 0; cardIndex < self.cardButtons.count; cardIndex++) {
    UIButton *cardButton = self.cardButtons[cardIndex];
    Card *card = [self.game cardAtIndex:cardIndex];
    
    [self updateCardButtonUI:cardButton card:card];
    
  }
  
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",
                     (int)self.game.score];
  
  //The last record in the history is the currently chosen card set
  NSArray *currentChosenCardSet = self.game.history.lastObject;
  
  self.matchUnmatchLabel.attributedText = [self cardSetMatchOrUnmatchDescription:currentChosenCardSet];
  
}


- (NSAttributedString *)cardSetMatchOrUnmatchDescription:(NSArray *)cardSet {
  NSMutableAttributedString *matchUnmatchDescription = [[NSMutableAttributedString alloc] init];
  
  if ((cardSet == nil) || (cardSet.count == 0)) {
    //Empty or undefined card set
    return matchUnmatchDescription;
  }
  
  for (Card *card in cardSet) {
    NSAttributedString *cardAttributedTitle = [self attributedTitleForCard:card];
    [matchUnmatchDescription appendAttributedString:cardAttributedTitle];
    if (card != [cardSet lastObject]) {
      [matchUnmatchDescription appendAttributedString:[[NSAttributedString alloc]
                                                       initWithString:@", "]];
    }
  }
  
  if ([cardSet count] > 1) {
    Card *firstCard = [cardSet firstObject];
    NSUInteger match = [firstCard.class match:cardSet];
    
    NSAttributedString *prefix;
    NSAttributedString *body   = [[NSMutableAttributedString alloc]
                                  initWithAttributedString:matchUnmatchDescription];
    NSAttributedString *suffix;
    
    
    if (match) {
      prefix = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
      suffix = [[NSMutableAttributedString alloc] initWithString:[NSString                                                           stringWithFormat:@" for %lu points.", match * self.game.matchingBonus]];
    } else {
      prefix = [[NSMutableAttributedString alloc] initWithString:@""];
      suffix = [[NSMutableAttributedString alloc] initWithString:[NSString                                                           stringWithFormat:@" don’t match! %lu point penalty!", self.game.mismatchPenalty]];    }
    
    matchUnmatchDescription = [[NSMutableAttributedString alloc]
                               initWithAttributedString:prefix];
    [matchUnmatchDescription appendAttributedString:body];
    [matchUnmatchDescription appendAttributedString:suffix];
  }
  return matchUnmatchDescription;
}

- (void)updateCardButtonUI:(UIButton *)cardButton card:(Card *)card {

}

@end
