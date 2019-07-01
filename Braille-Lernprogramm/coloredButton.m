//
//  coloredButton.m
//  Braille Übungen
//
//  Created by Alexander Eiselt on 26.09.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "coloredButton.h"

@implementation coloredButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setupWithColor:(UIColor*)color
{
    self.backgroundColor = color;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.cornerRadius = 10.0f;
}

@end
