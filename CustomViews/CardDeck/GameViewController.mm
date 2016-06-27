//
//  ViewController.m
//  CardDeck
//
//  Created by Gershon on 16/06/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "GameViewController.h"
#import "Grid.h"

//To be removed !!!
#import "PlayingCardView.h"

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *cardsContainerView;
@property (strong, nonatomic) Grid *grid;
@property (nonatomic) BOOL animationInProgress;

@end

@implementation GameViewController

#pragma - mark Event handlers

- (IBAction)dealMore:(id)sender {
  NSUInteger cardsToDeal = self.game.cardsToChoose;
  NSUInteger cardsActuallyDealed = [self.game drawCardsFromDesk:self.game.cardsToChoose
                                                      usingDeck:self.deck];
  
  if (cardsActuallyDealed < cardsToDeal) {
    [self animateShock];
    return;
  }
  
  [self updateUI];
  
  NSMutableArray *cardIndexes = [[NSMutableArray alloc] init];
  
  for (NSInteger cardIndex = self.game.cardCount - 1;
       cardIndex >= self.game.cardCount - cardsActuallyDealed;
       cardIndex--) {
      [cardIndexes addObject:[NSNumber numberWithInteger:cardIndex]];
  }
  
  [self animateCardsArrival:cardIndexes];
}


- (IBAction)onRedeal:(id)sender {
  
  //New deck and cards
  self.deck = nil;
  self.game = nil;
  
  [self updateUI];
  
  //Bring new cards
  NSMutableArray *cardIndexesToBring = [[NSMutableArray alloc] init];
  
  for (NSInteger cardIndex = 0; cardIndex < self.game.cardCount; cardIndex++) {
    [cardIndexesToBring addObject:[NSNumber numberWithInteger:cardIndex]];
  }
  
  [self animateCardsArrival:cardIndexesToBring];
  
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
  if(sender.state != UIGestureRecognizerStateRecognized) {
    return;
  }
  
  CGPoint point = [sender locationInView:sender.view];
  NSInteger cellIndex = [self.grid indexOfCellAtPoint:point];
  
  if ((cellIndex < 0) || (cellIndex >= self.game.cardCount)) {
    return;
  }
  
  [self chooseCardAtIndex:cellIndex];
  [self removeMatchedCardsIfNeeded];
  
  [self updateUI];
}

- (void)chooseCardAtIndex:(NSInteger)index {
  
  BOOL cardWasChosen = [self.game cardAtIndex:index].isChosen;
  [self.game chooseCardAtIndex:index];
  BOOL cardIsChosen = [self.game cardAtIndex:index].isChosen;

  if ((cardWasChosen != cardIsChosen) && self.shouldFlipChosenCard) {
    [self animateCardFlip:index];
  }
}

- (void)removeMatchedCardsIfNeeded {
  if (!self.shouldRemoveMatchingCards) {
    return;
  }
  
  NSMutableArray *cardIndexesToRemove = [[NSMutableArray alloc] init];
  
  for (NSInteger cardIndex = self.game.cardCount - 1; cardIndex >= 0; cardIndex--) {
    if ([self.game cardAtIndex:cardIndex].isMatched) {
      [cardIndexesToRemove addObject:[NSNumber numberWithInteger:cardIndex]];
    }
  }
  
  if (cardIndexesToRemove.count) {
    [self animateCardsRemoval:cardIndexesToRemove];
  }
}


#pragma - mark Animations

-(void) animationStarted {
  self.animationInProgress = YES;
}

-(void) animationFinished {
  self.animationInProgress = NO;
  [self updateUI];
}

- (void)animateCardFlip:(NSUInteger) index {
  [self animationStarted];
  
  UIView *cardView = [[self.cardsContainerView subviews] objectAtIndex:index];
  
  [UIView beginAnimations:@"View Flip" context:nil];
  [UIView setAnimationDuration:0.80];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                         forView:cardView cache:NO];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(animationFinished)];
  
  [UIView commitAnimations];
  
}

- (void)animateShock {
  [self animationStarted];
  CGPoint oldCenter = self.cardsContainerView.center;
  CGPoint newCenter = CGPointMake(oldCenter.x + 10, oldCenter.y);
  [UIView animateWithDuration:0.1 delay:0 options:(UIViewAnimationOptionAutoreverse)
    animations:^{
      self.cardsContainerView.center = newCenter;
    }
    completion:^(BOOL finished) {
      if (finished) {
        self.cardsContainerView.center = oldCenter;
        [self animationFinished];
      }
    }
  ];
}

- (void)animateCardsRemoval:(NSArray *)cardIndexes {
  [self animationStarted];
  
  int targetX = self.cardsContainerView.bounds.size.width * 0.5;
  int targetY = - self.cardsContainerView.bounds.size.height * 0.5;
  CGPoint target = CGPointMake(targetX, targetY);
  
  [UIView animateWithDuration:1.0
                   animations:^{
                     for (NSNumber *cardIndex in cardIndexes) {
                       UIView *cardView = [[self.cardsContainerView subviews] objectAtIndex:cardIndex.integerValue];
                       cardView.center = target;
                     }
                   }
                   completion:^(BOOL finished) {
                     if (finished) {
                       for (NSNumber *cardIndex in cardIndexes) {
                         [self.game removeCardAtIndex:cardIndex.integerValue];
                       }
                       [self animationFinished];
                     }
                   }];
}

- (void)animateCardsArrival:(NSArray *)cardIndexes {
  [self animationStarted];
  
  int sourceX = self.cardsContainerView.bounds.size.width * 0.5;
  int sourceY = self.cardsContainerView.bounds.size.height * 1.5;
  CGPoint source = CGPointMake(sourceX, sourceY);
 
  for (NSNumber *cardIndex in cardIndexes) {
    UIView *cardView = [[self.cardsContainerView subviews] objectAtIndex:cardIndex.integerValue];
    cardView.center = source;
  }

  [UIView animateWithDuration:1.0
     animations:^{
       for (NSNumber *cardIndex in cardIndexes) {
         UIView *cardView = [[self.cardsContainerView subviews] objectAtIndex:cardIndex.integerValue];
         cardView.center = [self.grid centerOfCellAtIndex:cardIndex.integerValue];
       }
     }
     completion:^(BOOL finished) {
       if (finished) {
         [self animationFinished];
       }
     }
   ];
}

#pragma - mark View Controller Lifecycle

- (void) viewDidLoad {
  [super viewDidLoad];
  [self updateUI];
}

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self updateUI];
  
}

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
  
}


- (void)updateGrid {
  self.grid = [[Grid alloc] init];
  
  self.grid.minimumNumberOfCells = self.game.cardCount;
  self.grid.cellAspectRatio = self.cellAspectRatio;
  self.grid.size = self.cardsContainerView.frame.size;
}

- (void)updateUI {

  if (self.animationInProgress) {
    return;
  }
  
  //Delete existing subviews from the Cards Container
  [self.cardsContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  
  //Update grid parameters
  [self updateGrid];
  
  //Put cards into the cells
  for (NSUInteger cellIndex = 0; cellIndex <self.game.cardCount; cellIndex++) {
    Card* card = [self.game cardAtIndex:cellIndex];
    CardView *cardView = [self.cardViewBuilder buildCardViewFromCard:card];
    
    CGRect cardFrame = [self.grid frameOfCellAtIndex:cellIndex];
    cardView.frame = cardFrame;
    
    [self.cardsContainerView addSubview:cardView];
  }
  
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",
                          (int)self.game.score ];
  

}

@end
