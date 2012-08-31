//
//  AsyncUIImage.m
//  UIAsyncImageView
//
//  Created by Rasmus Theodor Styrk on 28/06/12.
//  Copyright (c) 2012 Styrk-IT. All rights reserved.
//

#import "AsyncUIImage.h"

@implementation AsyncUIImage

#pragma mark - Properties

@synthesize callback = _callback;
@synthesize imageUrl = _imageUrl;
@synthesize imageData = _imageData;
@synthesize delegate = _delegate;

#pragma mark - 

- (id) initWithUrlString:(NSString *)url
{
	self = [super init];
	
	if(self)
	{
		_imageUrl = [[NSURL URLWithString:url] retain];
		_imageData = [[NSMutableData alloc] init];
		self.callback = nil;
	}
	
	return self;
}

+ (id) imageFromUrlString:(NSString *)url onCompleted:(AsyncUIImageCallback)callback
{
	AsyncUIImage *image = [[self alloc] initWithUrlString:url];
	[image setCallback:callback];
	[image load]; // Should we do this here? might be better to let caller do it? like this perhaps: [[AsyncUIImage imageFromUrlString:.. onCompleted:..] load];

	return [image autorelease];
}

- (void) load
{
	NSURLRequest *request = [NSURLRequest requestWithURL:self.imageUrl
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:10.0];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];	
	
	[connection start]; // We know this is seen as a leak, but we relase connection later in delegate methods
}

- (void) dealloc
{
	Block_release(_callback);
	_callback = nil;
	[_imageUrl release];
	[_imageData release];

	[super dealloc];
}

#pragma mark - URL Connection delegates

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.imageData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if([self.delegate respondsToSelector:@selector(AsyncUIImage:didFailWithError:)])
	{
		[self.delegate AsyncUIImage:self didFailWithError:error];
	}
	else if(self.callback != nil)
	{
		self.callback(nil, error);
	}
	
	[connection release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if([self.delegate respondsToSelector:@selector(AsyncUIImage:didFinishWithImage:)])
	{
		[self.delegate AsyncUIImage:self didFinishWithImage:[UIImage imageWithData:self.imageData]];
	}
	else if(self.callback != nil)
	{
		self.callback([UIImage imageWithData:self.imageData], nil);
	}
	
    [connection release];
}

@end
