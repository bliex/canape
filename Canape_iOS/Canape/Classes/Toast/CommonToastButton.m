//
//  CommonToastButton.m
//  CanapeProject
//
//  Canape Software License
//  Copyright (c) 2016 BliexSoft, Inc.
//
//  Permission to use, copy, modify, and distribute this software
//  and its documentation for any purpose, without fee, and without
//  a written agreement is hereby granted, provided that the above
//  copyright notice and this and the following paragraphs appear
//  in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "CommonToastButton.h"
//#import "Colors.h"
//#import "Fonts.h"

@implementation CommonToastButton

@synthesize imgIcon;
@synthesize labelTitle;

- (id) init {
    self = [super init];
    
    imgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_popup_undo"]];
    [imgIcon sizeToFit];
    [self addSubview:imgIcon];
    
    labelTitle = [[UILabel alloc]init];
    [labelTitle setText:@"UNDO"];
    [labelTitle setTextColor:[UIColor greenColor]];
//    [labelTitle setTextColor:RGB(86, 201, 212)];
    //[labelTitle setFont:[UIFont fontWithName:H_N_LIGHT size:50/3]];
    [labelTitle sizeToFit];
    //[labelTitle setFrame:CGRectMake(imgIcon.frame.size.width + pixelToPointX(9), 0, labelTitle.frame.size.width, labelTitle.frame.size.height)];
    [self addSubview:labelTitle];
    
    return self;
}

- (void) sizeToFit {
    [super sizeToFit];
    
    [self setFrame:CGRectMake(0, 0, labelTitle.frame.origin.x + labelTitle.frame.size.width, labelTitle.frame.size.height)];
}

@end
