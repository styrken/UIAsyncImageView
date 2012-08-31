//
//  AsyncUIImage.h
//  UIAsyncImageView
//
//  Created by Rasmus Theodor Styrk on 28/06/12.
//  Copyright (c) 2012 Styrk-IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsyncUIImageDelegate;

/**
 * Class for fethching an UIImage given an url, async..
 * 
 */
@interface AsyncUIImage : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

#pragma mark - Properties
/**
 * Callback block
 *
 */
typedef void (^AsyncUIImageCallback)(UIImage *image, NSError *error);
@property (nonatomic, copy) AsyncUIImageCallback callback;

/**
 * Image URL
 *
 */
@property (nonatomic, retain, readonly) NSURL *imageUrl;

/**
 * Image data
 *
 */
@property (nonatomic, retain, readonly) NSMutableData *imageData;

/**
 * If you want to use delegates instead of block
 *
 */
@property (nonatomic, assign, readonly) id <AsyncUIImageDelegate> delegate;

#pragma mark - Methods

/**
 * Normal init
 *
 * @param url The urlt o load
 */
- (id) initWithUrlString:(NSString*)url;

/**
 * Starts to load image from url
 *
 */
- (void) load;

#pragma mark - Static methods

/**
 * Static init
 */
+ (id) imageFromUrlString:(NSString*)url onCompleted:(AsyncUIImageCallback) callback;

@end

@protocol AsyncUIImageDelegate <NSObject>

@optional
- (void) AsyncUIImage:(AsyncUIImage*)asyncImage didFinishWithImage:(UIImage*)image;
- (void) AsyncUIImage:(AsyncUIImage*)asyncImage didFailWithError:(NSError*)error;

@end