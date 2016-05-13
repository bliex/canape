//
//  CommonToast.h
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

#import <UIKit/UIKit.h>

@class CommonToast;

// Toast 타입
typedef enum : NSUInteger {
    TOAST_TYPE_DEFAULT,     // 기본형
    TOAST_TYPE_BUTTON,      // 버튼이 있는 Toast
} CommonToastType;

@protocol CommonToastDelegate <NSObject>

@optional
/**
 * @brief 버튼 선택시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @return nil
 */
- (void) didSelectToastButton;

/**
 * @brief toast hide 완료 된 시점에서 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @return nil
 */
- (void) didToastHideComplete;

@end

@interface CommonToast : UIView

@property (strong, nonatomic) NSString *text;
@property (weak) id <CommonToastDelegate> delegate;
@property (nonatomic) CommonToastType toastType;

/**
 * @brief Toast Initialize
 * @param frame : 위치 / 크기 설정
 * @param toastType : Toast 타입 설정(기본/버튼형)
 * @return nil
 */
- (id)initWithFrame:(CGRect)frame andToastType:(CommonToastType)toastType andToastHeight:(float)toastHeight;


/**
 * @brief Toast Show
 * @param text : 표시할 텍스트
 * @param duration : 보여질 시간 설정
 * @return nil
 */
+ (void)showToastWithText:(NSString *)text withDuaration:(float)duration;



/**
 * @brief Toast Show
 * @param text : 표시할 텍스트
 * @param duration : 보여질 시간 설정
 * @return nil
 */
+ (void)showToastWithText:(NSString *)text withDuaration:(float)duration parentView:(UIView *)parentView;

/**
 * @brief Toast Show
 * @param text : 표시할 텍스트
 * @param duration : 보여질 시간 설정
 * @param toastType : toast 타입 설정
 * @param delegate : delegate 구현할 객체 설정
 * @return nil
 */
+ (void)showToastWithText:(NSString *)text withDuaration:(float)duration andToastType:(CommonToastType)toastType delegate:(id)delegate  parentView:(UIView *)parentView;

- (void)hideSelf;

+ (CGFloat)getLabelHeight:(NSString*) text;

@end
