//
//  UIWebViewExtensions.m
//  RecipeBook
//
//  Created by Marc  Winoto on 1/06/11.
//  Copyright 2011 Winoto. All rights reserved.
//

#import "UIWebViewExtensions.h"


@implementation UIWebView (UIWebViewExtensions)

- (CGSize)bodySize
{
    CGSize size;
    size.width = [[self stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"] integerValue];
    size.height = [[self stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] integerValue];
    return size;
}


- (CGSize)windowSize
{
    CGSize size;
    size.width = [[self stringByEvaluatingJavaScriptFromString:@"window.innerWidth"] integerValue];
    size.height = [[self stringByEvaluatingJavaScriptFromString:@"window.innerHeight"] integerValue];
    return size;
}

- (CGPoint)scrollOffset
{
    CGPoint pt;
    pt.x = [[self stringByEvaluatingJavaScriptFromString:@"window.pageXOffset"] integerValue];
    pt.y = [[self stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] integerValue];
    return pt;
}

-(CGSize) contentSize
{
    UIScrollView * scrollView = nil;
    for(UIView * v in [self subviews])
    {
        if([v isKindOfClass:[UIScrollView class]])
        {
            scrollView = (UIScrollView*)v;
            break;
        }
    }
    if(scrollView!=nil)
    {
        return scrollView.contentSize;
    }
    else
    {
        return CGSizeMake(0.0, 0.0);
    }
        
    /*
    CGSize size;
    size.width = [[self stringByEvaluatingJavaScriptFromString:@"window.outerWidth"] integerValue];
    size.height = [[self stringByEvaluatingJavaScriptFromString:@"window.outerHeight"] integerValue];
    return size;
    */
}

-(float) scalingFactor
{
    //CGSize windowSize = [self windowSize];// what does the window do?
    
    CGSize contentSize = [self contentSize];
    CGSize bodySize = [self bodySize];
    return bodySize.width/contentSize.width;
    
    
    /*
    CGSize contentSize = [self contentSize];
    CGFloat scale = self.frame.size.width / contentSize.width;
    return scale;
    */
}

-(NSString *) pageTitle
{
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void) findImage
{
    
}

-(void) alternateTouch:(UITouch*) sender
{
    // Scroll offset
    int scrollPositionY = [[self stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] intValue];
    int scrollPositionX = [[self stringByEvaluatingJavaScriptFromString:@"window.pageXOffset"] intValue];
    // Scale ratio
    int displayWidth = [[self stringByEvaluatingJavaScriptFromString:@"window.outerWidth"] intValue];
    CGFloat scale = self.frame.size.width / displayWidth;
    // Point in the webview
    CGPoint pt = [sender locationInView:self];  
    pt.x *= scale;
    pt.y *= scale;
    pt.x += scrollPositionX;
    pt.y += scrollPositionY;
    // This will get the tag name at the point
    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", pt.x, pt.y];
    //NSString * tagName = 
    [self stringByEvaluatingJavaScriptFromString:js];
    // This will get the img URL at the point
    //NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", startPoint.x, startPoint.y];
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    //NSString *urlToSave = 
    [self stringByEvaluatingJavaScriptFromString:imgURL];
    
}

@end
