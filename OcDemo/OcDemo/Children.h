//
//  Children.h
//  OcDemo
//
//  Created by 马壮 on 2024/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChildrenDelegate <NSObject>
-(void)eat;
@end

@interface Children : NSObject
@property(nonatomic,weak) id<ChildrenDelegate> delegete;
@end

NS_ASSUME_NONNULL_END
