//
//  AsyncImageView.h
//  UIAsyncImageView
//
//  Created by Rasmus Theodor Styrk on 28/06/12.
//  Copyright (c) 2012 Styrk-IT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class can load an image async into an image view. While image is loading there is shown a spinner
 * to indicate network activity
 *
 */
@interface AsyncImageView : UIImageView

#pragma mark - Properties

/**
 * This is the spinner :D
 *
 */
@property (nonatomic, retain, readonly) UIActivityIndicatorView *spinner;

#pragma mark - Methods

/**
 * Inits an UIImageView with a frame and loads url into it using async http
 *
 * @param url Any url that contains an image
 * @param frame The size of the image view
 */
- (id) initWithUrlString:(NSString*)url andFrame:(CGRect)frame;

/**
 * Loads another image url
 *
 * @param url The url to load
 */
- (void) loadUrlString:(NSString*)url;

/**
 * If you want an action and target fired when view is clicked
 *
 * @param target The target object
 * @param action The selector method on the object
 */
- (void) addTarget:(id)target forAction:(SEL)selector;

@end
