// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "TripletCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TripletCardView



#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

- (void)setNumber:(TripletCardAttributeValue)number
{
  _number = number;
  [self setNeedsDisplay];
}

- (void)setSymbol:(TripletCardAttributeValue)symbol
{
  _symbol = symbol;
  [self setNeedsDisplay];
}

- (void)setFilling:(TripletCardAttributeValue)filling
{
  _filling = filling;
  [self setNeedsDisplay];
}

- (void)setColor:(TripletCardAttributeValue)color
{
  _color = color;
  [self setNeedsDisplay];
}

- (void)setChosen:(BOOL)chosen
{
  _chosen = chosen;
  [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  [self drawBounds];
  [self drawSymbols];
}

- (void)drawBounds {
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];

  if (self.isChosen) {
    roundedRect.lineWidth = 5.0;
  }

  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
}

- (void)drawSymbols {
  NSUInteger symbolCount = [self symbolCount];
  
  CGFloat distanceBetweenSymbols = [self cornerRadius];
  //We use cornerRadius as distance between the border and the first/last symbol
  //as well as distance between symbols
  
  CGFloat symbolWidth = (self.bounds.size.width - 4 * distanceBetweenSymbols) / 3.0;
  CGFloat symbolHeight = self.bounds.size.height - 2 * distanceBetweenSymbols;
  
  CGFloat symbolOriginX = distanceBetweenSymbols +
      (3 - symbolCount) * (symbolWidth + distanceBetweenSymbols) * 0.5;
  CGFloat symbolOriginY = distanceBetweenSymbols;
  
  for (NSUInteger symbolIndex = 0; symbolIndex < symbolCount; symbolIndex++) {
    [self drawOneSymbolInRect:CGRectMake(symbolOriginX, symbolOriginY, symbolWidth, symbolHeight)];
    symbolOriginX += (symbolWidth + distanceBetweenSymbols);
  }
}


- (void)drawOneSymbolInRect:(CGRect)rect {
  
  UIBezierPath *bezierPath = [self symbolBezierPathInRect:rect];
  
  [self pushContext];
  
  [bezierPath addClip];
  
  [[self symbolColor] setFill];
  [self fillRectWithSymbolFilling:rect];
  
  [self popContext];
  
  bezierPath.lineWidth = 3.0;
  [[self symbolColor] setStroke];
  [bezierPath stroke];
}

- (void)fillRectWithSymbolFilling:(CGRect)rect {
  switch ([self filling]) {
    case TripletCardAttributeValueOne: //Empty filling - nothing to do
      return;
      
    case TripletCardAttributeValueTwo: {
      //Stripped filling
    
      CGFloat stepBetweenLines = 4.0;
      CGFloat lineWidth = 2.0;
      UIBezierPath *strippedLines = [[UIBezierPath alloc] init];
      for (CGFloat lineX = rect.origin.x; lineX < rect.origin.x + rect.size.width; lineX += stepBetweenLines) {
        [strippedLines    moveToPoint:CGPointMake(lineX, rect.origin.y)];
        [strippedLines addLineToPoint:CGPointMake(lineX, rect.origin.y + rect.size.height)];
      }
      strippedLines.lineWidth = lineWidth;
      [[self symbolColor] setStroke];
      [strippedLines stroke];
      return;
    }
      
    case TripletCardAttributeValueThree: //Solid filling
      UIRectFill(rect);
      return;
      
    default:
      return;
  }
  
}

- (NSUInteger) symbolCount {
  switch ([self number]) {
    case TripletCardAttributeValueOne:
      return 1;
    case TripletCardAttributeValueTwo:
      return 2;
    case TripletCardAttributeValueThree:
      return 3;
    default:
      return 0;
  }
}

- (UIColor *) symbolColor {
  switch ([self color]) {
    case TripletCardAttributeValueOne:
      return [UIColor redColor];
    case TripletCardAttributeValueTwo:
      return [UIColor greenColor];
    case TripletCardAttributeValueThree:
      return [UIColor purpleColor];
    default:
      return [UIColor blackColor];
  }
}

- (UIBezierPath *)squiggleInRect:(CGRect)rect {
  CGFloat originX = rect.origin.x;
  CGFloat originY = rect.origin.y;
  CGFloat width   = rect.size.width;
  CGFloat height  = rect.size.height;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(15, 104)];
  [path addCurveToPoint:CGPointMake(54 , 63)  controlPoint1:CGPointMake(36.9, 112.4) controlPoint2:CGPointMake(60.8, 89.7  )];
  [path addCurveToPoint:CGPointMake(53 , 27)  controlPoint1:CGPointMake(51.3, 52.3 ) controlPoint2:CGPointMake(42  , 42.2  )];
  [path addCurveToPoint:CGPointMake(40 , 5)   controlPoint1:CGPointMake(65.6, 9.6  ) controlPoint2:CGPointMake(58.3, 5.4   )];
  [path addCurveToPoint:CGPointMake(12 , 36)  controlPoint1:CGPointMake(22  , 4.6  ) controlPoint2:CGPointMake(9.7 , 19.1  )];
  [path addCurveToPoint:CGPointMake(14 , 89)  controlPoint1:CGPointMake(15.2, 59.2 ) controlPoint2:CGPointMake(31.5, 61.9  )];
  [path addCurveToPoint:CGPointMake(15 ,104)  controlPoint1:CGPointMake(10  , 95.3 ) controlPoint2:CGPointMake(6.9 , 100.9 )];
  
  [path applyTransform:CGAffineTransformMakeScale(0.9524 * width/50, 0.9524 * height/100)];
  [path applyTransform:CGAffineTransformMakeTranslation(originX - width * 0.15, originY)];
  
  return path;
}

- (UIBezierPath *)diamondInRect:(CGRect)rect {
  CGFloat originX = rect.origin.x;
  CGFloat originY = rect.origin.y;
  CGFloat width   = rect.size.width;
  CGFloat height  = rect.size.height;
  
  
  UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
  [bezierPath    moveToPoint:CGPointMake(originX + 0.5 * width, originY + 0.0 * height)];
  [bezierPath addLineToPoint:CGPointMake(originX + 1.0 * width, originY + 0.5 * height)];
  [bezierPath addLineToPoint:CGPointMake(originX + 0.5 * width, originY + 1.0 * height)];
  [bezierPath addLineToPoint:CGPointMake(originX + 0.0 * width, originY + 0.5 * height)];
  [bezierPath addLineToPoint:CGPointMake(originX + 0.5 * width, originY + 0.0 * height)];
  
  return bezierPath;
}

- (UIBezierPath *)ovalInRect:(CGRect)rect {
    return [UIBezierPath bezierPathWithRoundedRect:rect
                                      cornerRadius:0.5*MIN(rect.size.width, rect.size.height)];
}

- (UIBezierPath *)symbolBezierPathInRect:(CGRect)rect {
  switch ([self symbol]) {
    case TripletCardAttributeValueOne:
      return [self squiggleInRect:rect];
      
    case TripletCardAttributeValueTwo:
      return [self diamondInRect:rect];
      
    case TripletCardAttributeValueThree:
      return [self ovalInRect:rect];
      
    default:
      return nil;
  }
}


- (void)pushContext {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
}

- (void)popContext
{
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


#pragma mark - Initialization

- (void)setup
{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  [self setup];
  return self;
}




@end

NS_ASSUME_NONNULL_END
