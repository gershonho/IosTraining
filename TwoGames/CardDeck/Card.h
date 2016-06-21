// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Gershon.
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

+ (int)match:(NSArray *)cards;

@end

NS_ASSUME_NONNULL_END
