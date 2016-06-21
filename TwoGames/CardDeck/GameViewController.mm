//
//  ViewController.m
//  CardDeck
//
//  Created by Gershon on 16/06/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

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
}

- (void)updateCardButtonUI:(UIButton *)cardButton card:(Card *)card {

}

@end
