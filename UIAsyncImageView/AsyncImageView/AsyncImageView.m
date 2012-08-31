//
//  AsyncImageView.m
//  UIAsyncImageView
//
//  Created by Rasmus Theodor Styrk on 28/06/12.
//  Copyright (c) 2012 Styrk-IT. All rights reserved.
//

#import "AsyncImageView.h"
#import "AsyncUIImage.h"

@interface AsyncImageView ()
@property (nonatomic, assign, readonly) SEL actionSelector;
@property (nonatomic, assign, readonly) id targetObj;

@end

@implementation AsyncImageView

#pragma mark - Properties

@synthesize spinner = _spinner;
@synthesize actionSelector = _actionSelector;
@synthesize targetObj = _targetObj;

#pragma mark -

- (id) initWithUrlString:(NSString *)url andFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if(self)
	{
		int spinnerWidth = 20;
		int spinnerHeight = 20;
		
		_spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width / 2) - (spinnerWidth / 2), (self.frame.size.height / 2) - (spinnerHeight / 2), spinnerWidth, spinnerWidth)];
		
		[_spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
				
		[self addSubview:_spinner];
		[self loadUrlString:url];		
	}
	
	return self;
}

- (void) loadUrlString:(NSString *)url
{
	[_spinner startAnimating];

	[AsyncUIImage imageFromUrlString:url onCompleted:^(UIImage *image, NSError *error) {
		
		if(image != nil)
		{
			self.image = image;
		}
		
		[_spinner stopAnimating];
	}];
}

- (void) dealloc
{
	[_spinner release];
	_spinner = nil;
		
	[super dealloc];
}

#pragma mark - Target / action stuff

- (void) addTarget:(id)target forAction:(SEL)selector
{
	NSAssert(target != nil, @"Target cannot be nil");
	NSAssert(selector != nil, @"Action cannot be nil");
	
	_targetObj = target;
	_actionSelector = selector;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(_targetObj == nil)
		[super touchesBegan:touches withEvent:event];
	else 
	{
		[_targetObj performSelector:_actionSelector withObject:self];
	}
}


@end
