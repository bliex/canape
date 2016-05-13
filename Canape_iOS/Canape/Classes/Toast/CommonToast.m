//
//  CommonToast.m
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

#import "CommonToast.h"
#import "CommonToastButton.h"
#import "CanapeConstants.h"

#define HEIGHT_TOAST pixelToHeight(166)
#define WIDTH_TOAST pixelToWidth(1070)

@interface CommonToast ()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) CommonToastButton *btnUndo;

@end

@implementation CommonToast

@synthesize textLabel;
@synthesize btnUndo;
@synthesize delegate;

float const ToastGap = 10.0f;

float const fontSize = 13.0f;

- (id)initWithFrame:(CGRect)frame andToastType:(CommonToastType)toastType andToastHeight:(float)toastHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        // 배경 이미지 생성
        /*
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_TOAST, toastHeight)];
        //bg.image = [UIImage imageNamed:@"bg_popup_toast"];
        [bg setBackgroundColor:[UIColor blackColor]];
        [bg setAlpha:0.5];
        [self addSubview:bg];
         */
        
        //배경생성
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_TOAST, toastHeight)];
        bg.layer.cornerRadius = 20;
        bg.layer.masksToBounds = YES;
        [[bg layer] setBorderWidth:0.5f];
        [[bg layer] setBorderColor:[UIColor grayColor].CGColor];
        [bg setBackgroundColor:[UIColor blackColor]];
        [bg setAlpha:0.5];
        [self addSubview:bg];
        
        
        // 텍스트 생성
        textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont systemFontOfSize:fontSize];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:textLabel];
        
        [self setToastType:toastType];
    }
    return self;
}

// 타입 설정 (기본 형 / 버튼 형)
- (void)setToastType:(CommonToastType)toastType {
    _toastType = toastType;
    
    if (toastType == TOAST_TYPE_DEFAULT) {
        [textLabel setFrame:CGRectMake(pixelToPointX(85), 0, self.frame.size.width - pixelToWidth(85) * 2, self.frame.size.height)];
        textLabel.textAlignment = NSTextAlignmentCenter;
        
        if (btnUndo != nil) {
            [btnUndo setHidden:YES];
        }
        
    } else {
        if (btnUndo == nil) {
            // 버튼 생성
            btnUndo = [[CommonToastButton alloc] init];
            [btnUndo sizeToFit];
            [btnUndo setFrame:CGRectMake(self.frame.size.width - pixelToWidth(85) - btnUndo.frame.size.width, self.frame.size.height / 2 - btnUndo.frame.size.height / 2, btnUndo.frame.size.width, btnUndo.frame.size.height)];
            [btnUndo addTarget:self action:@selector(onBtnUndoTouch:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnUndo];
        }
        [btnUndo setHidden:NO];
        
        CGRect rect = CGRectMake(pixelToPointX(85), 0, self.frame.size.width - (pixelToWidth(85) * 2) - btnUndo.frame.size.width - pixelToPointX(27), self.frame.size.height);
        [textLabel setFrame:rect];
        textLabel.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textLabel.text = text;
    
}

- (void) setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];
    
    [textLabel setAlpha:alpha];
}

- (void)onBtnUndoTouch:(id)sender {
    if (delegate != nil && [delegate respondsToSelector:@selector(didSelectToastButton)]) {
        [delegate didSelectToastButton];
    }
}

+ (void)showToastWithText:(NSString *)text withDuaration:(float)duration
{
    [self showToastWithText:text withDuaration:duration andToastType:TOAST_TYPE_DEFAULT delegate:nil parentView:nil];
}

+ (void)showToastWithText:(NSString *)text withDuaration:(float)duration  parentView:(UIView *)parentView
{
    [self showToastWithText:text withDuaration:duration andToastType:TOAST_TYPE_DEFAULT delegate:nil parentView:parentView];
}

+ (void)showToastWithText:(NSString *)text withDuaration:(float)duration andToastType:(CommonToastType)toastType delegate:(id)delegate  parentView:(UIView *)parentView
{
    CGRect parentFrame = parentView.frame;
    UIWindow *topView = [[[UIApplication sharedApplication] delegate] window];
    //[DGHelper hideKeyboard];
    
    float appVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (parentView == nil) {
        if (appVersion >= 9.0) {
            for (UIWindow *testWindow in [[UIApplication sharedApplication] windows])
            {
                if ([NSStringFromClass([testWindow class]) isEqualToString:@"UIRemoteKeyboardWindow"]) {
                    topView = testWindow;
                    break;
                }
                
                
            }

        } else {
            for (UIWindow *testWindow in [[UIApplication sharedApplication] windows])
            {
                if (![[testWindow class] isEqual:[UIWindow class]])
                {
                    topView = testWindow;
                    break;
                }
            }
        }
        
        parentFrame = topView.frame;

    }
    
   
    
    float yOrigin = parentFrame.size.height - (pixelToHeight(88) + [self getLabelHeight:text] + 30);
    
    CGRect selfFrame = CGRectMake(parentFrame.size.width / 2 - WIDTH_TOAST / 2, yOrigin, WIDTH_TOAST, [self getLabelHeight:text] + 30);
    
    CommonToast *toast = [[CommonToast alloc] initWithFrame:selfFrame andToastType:toastType andToastHeight:([self getLabelHeight:text] + 30)];
    toast.delegate = delegate;
    toast.alpha = 0.0f;
    toast.text = text;
    
    if (parentView == nil) {
        [topView addSubview:toast];
    } else {
        [parentView addSubview:toast];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        toast.alpha = 1.0f;
    }completion:^(BOOL finished) {
        if(finished){
            
        }
    }];
    
    
    [toast performSelector:@selector(hideSelf) withObject:nil afterDelay:4.0f];
    
}

- (void)hideSelf
{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if(finished){
            if (delegate != nil && [delegate respondsToSelector:@selector(didToastHideComplete)]) {
                // delegate 호출
                [delegate didToastHideComplete];
            }
            
            [self removeFromSuperview];
        }
    }];
}


+ (CGFloat)getLabelHeight:(NSString*) text
{

    NSAttributedString *attributedText1 = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    CGRect rect1 = [attributedText1 boundingRectWithSize:(CGSize){WIDTH_TOAST, CGFLOAT_MAX}
                                                 options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                 context:nil];
    
    return ceil(rect1.size.height);
}

@end
