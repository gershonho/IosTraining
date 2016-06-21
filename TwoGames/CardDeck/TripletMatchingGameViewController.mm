// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "TripletMatchingGameViewController.h"

#import "TripletMatchingGame.h"
#import "TripletDeck.h"
#import "TripletCard.h"

NS_ASSUME_NONNULL_BEGIN


@implementation TripletMatchingGameViewController


- (Deck *)deck {
  if (super.deck == nil) {
    super.deck = [[TripletDeck alloc] init];
  }
  
  return super.deck;
}

- (Game *)game {
  if (super.game == nil) {
    super.game = [[TripletMatchingGame alloc] initWithCardCount:self.cardCount usingDeck:self.deck];
  }
  
  return super.game;
}

static NSString *kSymbolOne     = @"▲";
static NSString *kSymbolTwo     = @"●";
static NSString *kSymbolThree   = @"■";
static NSString *kSymbolUnknown = @"?";

+(NSString *)symbolToShow:(TripletCardAttributeValue)symbol {
  switch (symbol) {
    case TripletCardAttributeValueOne:
      return kSymbolOne;
    case TripletCardAttributeValueTwo:
      return  kSymbolTwo;
    case TripletCardAttributeValueThree:
      return  kSymbolThree;
    default: //Invalid value
      return  kSymbolUnknown;
  }
}

static const NSUInteger kOne     = 1;
static const NSUInteger kTwo     = 2;
static const NSUInteger kThree   = 3;
static const NSUInteger kUnknown = 5;

+(NSUInteger)numberOfSymbols:(TripletCardAttributeValue)number {
  switch (number) {
    case TripletCardAttributeValueOne:
      return kOne;
    case TripletCardAttributeValueTwo:
      return  kTwo;
    case TripletCardAttributeValueThree:
      return  kThree;
    default: //Invalid value
      return  kUnknown;
  }
}

+(UIColor *)borderColor:(TripletCardAttributeValue)color {
  switch (color) {
    case TripletCardAttributeValueOne:
      return [UIColor redColor];
    case TripletCardAttributeValueTwo:
      return [UIColor greenColor];
    case TripletCardAttributeValueThree:
      return [UIColor blueColor];
    default: //Invalid value
      return [UIColor whiteColor];
  }
}

+(UIColor *)dashedPatternColor:(TripletCardAttributeValue)color {
  NSString* patternImageName;
  switch (color) {
    case TripletCardAttributeValueOne:
      patternImageName = @"RedDashed";
      break;
    case TripletCardAttributeValueTwo:
      patternImageName = @"GreenDashed";
      break;
    case TripletCardAttributeValueThree:
      patternImageName = @"BlueDashed";
      break;
    default: //Invalid value
      return [UIColor whiteColor];
  }
  return [UIColor colorWithPatternImage:[UIImage imageNamed:patternImageName]];
}

+(UIColor *)fillColor:(TripletCardAttributeValue)color shading:(TripletCardAttributeValue)shading {
  switch (shading) {
    case TripletCardAttributeValueOne:
      //Shading is 1 - empty image - fill with white
      return [UIColor whiteColor];
      
    case TripletCardAttributeValueTwo:
      //Shading is 2 - dashed image - fill with appropriately colored dashed pattern
      return [self dashedPatternColor:color];
      
    case TripletCardAttributeValueThree:
      //Shadding is 3 - filled image - fill with the same color we use for border
      return [self borderColor:color];
      
    default: //Invalid value
      return [UIColor whiteColor];
  }
}

+ (NSAttributedString *)buttonAttributedTitleForTripletCard:(TripletCard *)card {
   //Initiate the button attributed title
    
    TripletCardAttributeValue number  = [card number];
    TripletCardAttributeValue symbol  = [card symbol];
    TripletCardAttributeValue shading = [card shading];
    TripletCardAttributeValue color   = [card color];
    
    //Select the symbol to show
    NSString *symbolToShow = [self.class symbolToShow:symbol];
    
    //Select how many time we repeat the symbol
    NSUInteger numberOfSymbols = [self.class numberOfSymbols:number];
    
    //Create the button text by proper repetition of the proper symbol
    NSString *buttonText = [@"" stringByPaddingToLength:numberOfSymbols
                                             withString:symbolToShow
                                        startingAtIndex:0];
    
    //Select the fill color.
    //It includes also the pattern (empty, dashed or full)
    UIColor *fillColor = [self fillColor:color shading:shading];
    
    //Select the border color
    UIColor *borderColor = [self borderColor:color];
    
    NSDictionary *buttonAttributes = @{
                                       NSForegroundColorAttributeName:fillColor,
                                       NSStrokeColorAttributeName:borderColor,
                                       NSStrokeWidthAttributeName:@-3};
    
    return
        [[NSAttributedString alloc] initWithString:buttonText attributes:buttonAttributes];
}

- (void)updateCardButtonUI:(UIButton *)cardButton card:(Card*)card {
  
  //First we calculate the button's Attributed Title
  NSAttributedString *newAttributedTitle =
      [self.class buttonAttributedTitleForTripletCard:card];
  
  //Now we get the current Attributed Title
  NSAttributedString *currentAttributedTitle =
      [cardButton attributedTitleForState:UIControlStateNormal];
  
  //If the new attributed title differs from the current - we assign it
  //We need this to prevent blinking
  
  if (![[newAttributedTitle description] isEqualToString:
        [currentAttributedTitle description]]) {
    [cardButton setAttributedTitle:newAttributedTitle forState:UIControlStateNormal];
  }
  
  //Now pick the background color
  
  //A default button is light-gray
  UIColor *backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
  
  if (card.isMatched) {
    //A matched card is dark-grey
    backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
  } else if (card.isChosen) {
    //A chosen card is light-yellow
    backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.0 alpha:1.0];
  }
  
  //Set the background color
  [cardButton setBackgroundColor:backgroundColor];
  
  //Now disable the card if it is already matched
  cardButton.enabled = !card.isMatched;
  
}

@end

NS_ASSUME_NONNULL_END
