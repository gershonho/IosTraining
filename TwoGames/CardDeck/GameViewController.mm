//
//  ViewController.m
//  CardDeck
//
//  Created by Gershon on 16/06/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "GameViewController.h"
#import "HistoryViewController.h"

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


- (NSAttributedString *)cardSetMatchOrUnmatchDescription:(NSArray *)historyRecord {
  NSMutableAttributedString *matchUnmatchDescription = [[NSMutableAttributedString alloc] init];
  
  if ((historyRecord == nil) || (historyRecord.count != 2)) {
    //Empty or undefined card set
    return matchUnmatchDescription;
  }
  
  //Comma-separated Attributed Titles of cards
  NSArray* cardSet = historyRecord[0];
  for (Card *card in cardSet) {
    NSAttributedString *cardAttributedTitle = [self attributedTitleForCard:card];
    [matchUnmatchDescription appendAttributedString:cardAttributedTitle];
    if (card != [cardSet lastObject]) {
      [matchUnmatchDescription appendAttributedString:[[NSAttributedString alloc]
                                                       initWithString:@", "]];
    }
  }
  
  //Score delta
  NSInteger scoreDelta = ((NSNumber *)historyRecord[1]).longValue;
    
  NSAttributedString *prefix;
  NSAttributedString *body   = [[NSMutableAttributedString alloc]
                                initWithAttributedString:matchUnmatchDescription];
  NSAttributedString *suffix;
  
  
  if (scoreDelta > 0) {
    prefix = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
    suffix = [[NSMutableAttributedString alloc] initWithString:[NSString                                                           stringWithFormat:@" for %lu points.", scoreDelta]];
  } else {
    prefix = [[NSMutableAttributedString alloc] initWithString:@""];
    suffix = [[NSMutableAttributedString alloc] initWithString:[NSString                                                           stringWithFormat:@" don’t match! %lu point penalty!", -scoreDelta]];
  }
  
  matchUnmatchDescription = [[NSMutableAttributedString alloc]
                             initWithAttributedString:prefix];
  [matchUnmatchDescription appendAttributedString:body];
  [matchUnmatchDescription appendAttributedString:suffix];

  return matchUnmatchDescription;
}

- (void)updateCardButtonUI:(UIButton *)cardButton card:(Card *)card {

}

- (NSAttributedString *) historyLog {
  NSArray *history = self.game.history;
  
  NSMutableAttributedString *historyLog = [[NSMutableAttributedString alloc] init];
  
  for (NSArray* cardSet in history) {
    [historyLog appendAttributedString:[self cardSetMatchOrUnmatchDescription:cardSet]];
    if (cardSet != [history lastObject]) {
      [historyLog appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
  }
  
  return historyLog;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSAttributedString *historyLog = [self historyLog];
  if ([segue.identifier containsString:@"History"]) {
    ((HistoryViewController *) segue.destinationViewController).historyLog = historyLog;
  }
  
}

@end
