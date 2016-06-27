//
//  Grid.m
//
//  CS193p Fall 2013
//  Copyright (c) 2013 Stanford University.
//  All rights reserved.
//


#import "Grid.h"
#import <UIKit/UIKit.h>


const static NSUInteger kInvalidIndex = (-1);

@interface Grid()
@property (nonatomic) BOOL resolved;
@property (nonatomic) BOOL unresolvable;
@property (nonatomic, readwrite) NSUInteger rowCount;
@property (nonatomic, readwrite) NSUInteger columnCount;
@property (nonatomic, readwrite) CGSize cellSize;
@end

@implementation Grid

- (void)validate
{
  if (self.resolved) return;    // already valid, nothing to do
  if (self.unresolvable) return;  // already tried to validate and couldn't
  
  double overallWidth = ABS(self.size.width);
  double overallHeight = ABS(self.size.height);
  double aspectRatio = ABS(self.cellAspectRatio);
  
  if (!self.minimumNumberOfCells || !aspectRatio || !overallWidth || !overallHeight) {
    self.unresolvable = YES;
    return; // invalid inputs
  }
  
  double minCellWidth = self.minCellWidth;
  double minCellHeight = self.minCellHeight;
  double maxCellWidth = self.maxCellWidth;
  double maxCellHeight = self.maxCellHeight;
  
  if (minCellWidth < 0) minCellWidth = 0;
  if (minCellHeight < 0) minCellHeight = 0;
  
  BOOL hGridExists = NO;
  BOOL vGridExists = NO;
  
  int columnCountH = 0, columnCountV = 0, rowCountH = 0, rowCountV = 0;
  double cellWidthH = 0, cellWidthV = 0, cellHeightH = 0, cellHeightV = 0;
  
  columnCountH = 1;
  while (YES) {
    cellWidthH = overallWidth / (double)columnCountH;
    if (cellWidthH <= minCellWidth) {
      break;
    }
    cellHeightH = cellWidthH / aspectRatio;
    if (cellHeightH <= minCellHeight) {
      break;
    }
    rowCountH = (int)(overallHeight / cellHeightH);
    if ((rowCountH * columnCountH >= self.minimumNumberOfCells) &&
        ((maxCellWidth <= minCellWidth) || (cellWidthH <= maxCellWidth)) &&
        ((maxCellHeight <= minCellHeight) || (cellHeightH <= maxCellHeight))) {
      hGridExists = YES;
      break;
    }
    columnCountH++;
  }
  
  rowCountV = 1;
  while (YES) {
    cellHeightV = overallHeight / (double)rowCountV;
    if (cellHeightV <= minCellHeight) {
      break;
    }
    
    cellWidthV = cellHeightV * aspectRatio;
    if (cellWidthV <= minCellWidth) {
      break;
    }
    
    columnCountV = (int)(overallWidth / cellWidthV);
    if ((rowCountV * columnCountV >= self.minimumNumberOfCells) &&
        ((maxCellWidth <= minCellWidth) || (cellWidthV <= maxCellWidth)) &&
        ((maxCellHeight <= minCellHeight) || (cellHeightV <= maxCellHeight))) {
      vGridExists = YES;
      break;
    }
    
    rowCountV++;
  }
  
  self.resolved = YES;
  self.unresolvable = NO;
  if ((hGridExists && vGridExists & (cellWidthH > cellWidthV)) || (hGridExists && !vGridExists)) {
    self.rowCount = rowCountH;
    self.columnCount = columnCountH;
    self.cellSize = CGSizeMake(cellWidthH, cellHeightH);
  } else if ((hGridExists && vGridExists & (cellWidthH <= cellWidthV)) || (!hGridExists && vGridExists)) {
    self.rowCount = rowCountV;
    self.columnCount = columnCountV;
    self.cellSize = CGSizeMake(cellWidthV, cellHeightV);
  } else {
    self.resolved = NO;
    self.unresolvable = YES;
    self.rowCount = 0;
    self.columnCount = 0;
    self.cellSize = CGSizeZero;
  }
}

- (void)setResolved:(BOOL)resolved
{
    self.unresolvable = NO;
    _resolved = resolved;
}

- (BOOL)inputsAreValid
{
    [self validate];
    return self.resolved;
}

- (CGPoint)centerOfCellAtIndex:(NSUInteger)index {
  NSInteger row = index / self.columnCount;
  if ((row < 0) || (row >= self.rowCount)) {
    return CGPointZero;
  }
  
  NSInteger column = index - row * self.columnCount;
  if ((column < 0) || (column >= self.columnCount)) {
    return CGPointZero;
  }
  
  CGPoint center = CGPointMake(self.cellSize.width/2, self.cellSize.height/2);
  center.x += column * self.cellSize.width;
  center.y += row * self.cellSize.height;
  return center;
}

- (NSInteger)indexOfCellAtPoint:(CGPoint)point {
  NSInteger column = point.x / self.cellSize.width;
  if ((column < 0) || (column >= self.columnCount)) {
    return kInvalidIndex;
  }
  
  NSInteger row = point.y / self.cellSize.height;
  if ((row < 0) || (row >= self.rowCount)) {
    return kInvalidIndex;
  }
  
  return row * self.columnCount + column;
}

- (CGRect)frameOfCellAtIndex:(NSUInteger)index {
  NSInteger row = index / self.columnCount;
  if ((row < 0) || (row >= self.rowCount)) {
    return CGRectZero;
  }
  
  NSInteger column = index - row * self.columnCount;
  if ((column < 0) || (column >= self.columnCount)) {
    return CGRectZero;
  }
  
  CGRect frame = CGRectMake(column * self.cellSize.width, row * self.cellSize.height,
                            self.cellSize.width, self.cellSize.height);
  return frame;
}

- (void)setMinimumNumberOfCells:(NSUInteger)minimumNumberOfCells
{
    if (minimumNumberOfCells != _minimumNumberOfCells) self.resolved = NO;
    _minimumNumberOfCells = minimumNumberOfCells;
}

- (void)setSize:(CGSize)size
{
    if (!CGSizeEqualToSize(size, _size)) self.resolved = NO;
    _size = size;
}

- (void)setCellAspectRatio:(CGFloat)cellAspectRatio
{
    if (ABS(cellAspectRatio) != ABS(_cellAspectRatio)) self.resolved = NO;
    _cellAspectRatio = cellAspectRatio;
}

- (void)setMinCellHeight:(CGFloat)minCellHeight
{
    if (minCellHeight != _minCellHeight) self.resolved = NO;
    _minCellHeight = minCellHeight;
}

- (void)setMaxCellHeight:(CGFloat)maxCellHeight
{
    if (maxCellHeight != _maxCellHeight) self.resolved = NO;
    _maxCellHeight = maxCellHeight;
}

- (void)setMinCellWidth:(CGFloat)minCellWidth
{
    if (minCellWidth != _minCellHeight) self.resolved = NO;
    _minCellWidth = minCellWidth;
}

- (void)setMaxCellWidth:(CGFloat)maxCellWidth
{
    if (maxCellWidth != _maxCellWidth) self.resolved = NO;
    _maxCellWidth = maxCellWidth;
}

- (NSUInteger)rowCount
{
    [self validate];
    return _rowCount;
}

- (NSUInteger)columnCount
{
    [self validate];
    return _columnCount;
}

- (CGSize)cellSize
{
    [self validate];
    return _cellSize;
}

- (NSString *)description
{
    NSString *description = [NSString stringWithFormat:@"[%@] fitting %lu cells with aspect ratio %g into %@ -> ", NSStringFromClass([self class]), (unsigned long)self.minimumNumberOfCells, self.cellAspectRatio, NSStringFromCGSize(self.size)];
    
    if (!self.rowCount) {
        description = [description stringByAppendingString:@"invalid input: "];
        if (!self.minimumNumberOfCells || !self.cellAspectRatio || !self.size.width || !self.size.height) {
            if (!self.minimumNumberOfCells) description = [description stringByAppendingString:@"minimumNumberOfCells = 0;"];
            if (!self.cellAspectRatio) description = [description stringByAppendingString:@"cellAspectRatio = 0;"];
            if (!self.size.width) description = [description stringByAppendingString:@"size.width = 0;"];
            if (!self.size.height) description = [description stringByAppendingString:@"size.height = 0;"];
        } else {
            
            if (self.minCellWidth || self.minCellHeight) {
                description = [description stringByAppendingString:@"minimum width or height restricts grid to impossibility"];
                if (self.minCellWidth && self.minCellHeight) {
                    description = [description stringByAppendingFormat:@" (minCellWidth = %g, minCellHeight = %g)", self.minCellWidth, self.minCellHeight];
                } else if (self.minCellWidth) {
                    description = [description stringByAppendingFormat:@" (minCellWidth = %g)", self.minCellWidth];
                } else {
                    description = [description stringByAppendingFormat:@" (minCellHeight = %g)", self.minCellHeight];
                }
            } else {
                description = [description stringByAppendingString:@"internal error"];
            }
        }
    } else {
        description = [description stringByAppendingFormat:@"%luc x %lur at %@ each", (unsigned long)self.columnCount, (unsigned long)self.rowCount, NSStringFromCGSize(self.cellSize)];
    }
    
    return description;
}

@end
