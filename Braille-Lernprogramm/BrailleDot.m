//
//  BrailleDot.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "BrailleDot.h"

@implementation BrailleDot
@synthesize isselected, dotButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = frame;
        isselected = false;
        dotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dotButton.frame = self.bounds;
        [dotButton setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
        [self addSubview:dotButton];
    }
    return self;
}

-(BOOL)isAccessibilityElement
{
    return YES;
}

@end
