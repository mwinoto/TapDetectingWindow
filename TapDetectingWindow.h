#import <UIKit/UIKit.h>

@protocol TapDetectingWindowDelegate
-(UIView *) viewThatObservers;
-(void) userDidTouchView:(UITouch *)touch;
@end

@interface TapDetectingWindow : UIWindow {
 	// make an array of views so that we can get the taps in multiple windows
    NSMutableSet * _observers;
    
}

@property (nonatomic, strong) NSMutableSet * observers;

-(void) addTouchObserver:(id<TapDetectingWindowDelegate>)observer;
-(void) removeTouchObserver:(id<TapDetectingWindowDelegate>)observer;

@end
