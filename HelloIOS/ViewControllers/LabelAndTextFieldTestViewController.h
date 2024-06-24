//
//  ViewController.h
//  HelloIOS
//
//  Created by 马壮 on 2023/9/3.
//

#import <UIKit/UIKit.h>

@interface LabelAndTextFieldTestViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property (copy, nonatomic) NSString *bookName;

@end

