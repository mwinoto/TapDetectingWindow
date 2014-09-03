//
//  UIWebViewExtensions.h
//  RecipeBook
//
//  Created by Marc Winoto on 1/06/11.
//  Copyright 2011 Marc Winoto. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIWebView (UIWebViewExtensions)

-(CGSize) bodySize;
-(CGSize) windowSize;
-(CGPoint) scrollOffset;
-(CGSize) contentSize;
-(float) scalingFactor;
-(NSString *) pageTitle;
-(void) findImage;
@end
