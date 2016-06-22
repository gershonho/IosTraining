// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyLogTextView;

@end

@implementation HistoryViewController

- (void)setHistoryLog:(NSAttributedString *)historyLog {
  _historyLog = historyLog;
  
  if (self.view.window) {
    [self updateUI];
  }
}

- (void) viewWillAppear:(BOOL)animated {
  [self updateUI];
}

- (void) updateUI {
  NSMutableAttributedString *historyLog = [[NSMutableAttributedString alloc]
                                          initWithAttributedString:self.historyLog];
  
  [historyLog addAttribute:NSFontAttributeName
                     value:[UIFont fontWithName:@"Helvetica" size:14.0]
                     range:NSMakeRange(0, historyLog.length)];
  
  self.historyLogTextView.attributedText = historyLog;
}


@end

NS_ASSUME_NONNULL_END
