#import "TapDetectingWindow.h"

@implementation TapDetectingWindow

@synthesize observers=_observers;

-(id) init
{
    if((self=[super init]))
    {
        _observers = [[NSMutableSet alloc] init];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if((self=[super initWithCoder:aDecoder]))
    {
        _observers = [[NSMutableSet alloc] init];
    }
    return self;    
}

-(id) initWithFrame:(CGRect)frame
{
    if((self=[super initWithFrame:frame]))
    {
        _observers = [[NSMutableSet alloc] init];
    }
    return self;
}


/*
- (void)forwardTap:(id)touch 
{
    [controllerThatObserves userDidTapWebView:touch];
}
*/

- (void)sendEvent:(UIEvent *)event 
{
    [super sendEvent:event];
    
    if ([_observers count]==0)
        return;
    
    NSSet *touches = [event allTouches];
    if (touches.count != 1)
        return;
    
    UITouch *touch = touches.anyObject;
    if (touch.phase != UITouchPhaseEnded)
        return;
    
    for(id<TapDetectingWindowDelegate> delegate in _observers)
    {
        UIView * view = [delegate viewThatObservers];
        if ([touch.view isDescendantOfView:view] == NO)
            continue; //return;
        
        if (touch.tapCount == 1) 
        {
            [delegate userDidTouchView:touch]; //[self performSelector:@selector(forwardTap:) withObject:pointArray afterDelay:0.5];
        }
        /*
        else if (touch.tapCount > 1) 
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(forwardTap:) object:pointArray];
        }
        */
    }
}

-(void) addTouchObserver:(id<TapDetectingWindowDelegate>)observer
{
    [_observers addObject:observer];
}

-(void) removeTouchObserver:(id<TapDetectingWindowDelegate>)observer
{
    [_observers removeObject:observer];
}


@end
