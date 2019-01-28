//
//  DCMImgShow.h
//  DCMTKOOO
//
//  Created by ftimage2 on 2019/1/22.
//  Copyright © 2019 Jack Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^dcmReturn)(UIImage *imgData, long imgWidth, long  imgHeight);

@interface DCMImgShow : NSObject
-(void)getImgDataFileName:(NSString *)fileName withImgisInverse:(BOOL)isInverse withBlock:(dcmReturn)dicom;
@end

