//
//  TapDetectingWindow.h
//  RecipeBook
//
//  Created by Marc! on 31/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapDetectingWindowDelegate
-(UIView *) viewThatObservers;
-(void) userDidTouchView:(UITouch *)touch;
@end

@interface TapDetectingWindow : UIWindow {
 	// make an array of views so that we can get the taps in multiple windows
    NSMutableSet * _observers;
    
}

@property (nonatomic, retain) NSMutableSet * observers;

-(void) addTouchObserver:(id<TapDetectingWindowDelegate>)observer;
-(void) removeTouchObserver:(id<TapDetectingWindowDelegate>)observer;

@end