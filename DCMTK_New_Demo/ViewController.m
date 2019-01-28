//
//  ViewController.m
//  DCMTK_New_Demo
//
//  Created by ftimage2 on 2019/1/25.
//  Copyright © 2019 Jack Wang. All rights reserved.
//

#import "ViewController.h"
#import "DCMImgShow.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat ScreenWidht = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,100 , ScreenWidht, 100)];
    [self.view addSubview:imgView];
    
    DCMImgShow *dcmImg = [[DCMImgShow alloc] init];
    [dcmImg getImgDataFileName:@"ls1" withImgisInverse:true withBlock:^(UIImage *imgData, long imgWidth, long imgHeight) {
        dispatch_async(dispatch_get_main_queue(), ^{
            imgView.image = imgData;
            CGRect frame = imgView.frame;
            frame.size.height = ((CGFloat)imgHeight / (CGFloat)imgWidth) * ScreenWidht;
            imgView.frame = frame;
        });
    }];
}
@end
