//
//  KurzschriftCharacter.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "KurzschriftCharacter.h"

@implementation KurzschriftCharacter
@synthesize firstID, secondID, theSuperView, Name;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        firstID = 0;
        secondID = 0;
        Name = @"";
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
