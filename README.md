UIAsyncImageView
================

An UIImageView that loads asynchronous while displaying a spinner.

#### How to

1. Copy AsyncImageView folder to your project
2. #import "AsyncImageView.h"
3. Add AsyncImageView as a subview of your view

````objective-c
    NSString *url = @"https://raw.github.com/styrken/UIAsyncImageView/master/image.jpeg";
    AsyncImageView *image = [[AsyncImageView alloc] initWithUrlString:url
                                                             andFrame:CGRectMake(..)];
    
    [self.view addSubview:image];
    [image release];
````