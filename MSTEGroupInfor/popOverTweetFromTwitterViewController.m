//
//  popOverTweetFromTwitterViewController.m
//  MSTEGroupInfor
//
//  Created by Yukui Ye on 6/1/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import "popOverTweetFromTwitterViewController.h"

@interface popOverTweetFromTwitterViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) UIImageView *imageView;

@end

@implementation popOverTweetFromTwitterViewController


-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}


-(void)resetImage
{
    if(self.scrollView){
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        NSURL *imageURL = self.imageURL;
        dispatch_queue_t imageFetchQ = dispatch_queue_create("image fetcher", NULL);
        dispatch_async(imageFetchQ, ^{
            [NSThread sleepForTimeInterval:2.0];
            NSData  *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
            UIImage *image =[[UIImage alloc]initWithData:imageData];
            
            if(self.imageURL == imageURL){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(image){
                        self.scrollView.zoomScale = 1.0;
                        self.scrollView.contentSize = image.size;
                        self.imageView.image = image;
                        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                    }
                });
            }
        });
    }
}
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(UIImageView *) imageView
{
    if(!_imageView)
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    [self resetImage];
    
    
}



@end
