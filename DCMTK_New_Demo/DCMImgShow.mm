//
//  DCMImgShow.m
//  DCMTKOOO
//
//  Created by ftimage2 on 2019/1/22.
//  Copyright © 2019 Jack Wang. All rights reserved.
//

#import "DCMImgShow.h"
#import "DCMTKLib/dcmtk/dcmdata/dctk.h"
#import "DCMTKLib/dcmtk/dcmjpls/djdecode.h"
#import "DCMTKLib/dcmtk/dcmjpls/djencode.h"

#import "DCMTKLib/dcmtk/dcmimgle/dcmimage.h"

#import "DCMTKLib/dcmtk/dcmjpeg/djencode.h"
#import "DCMTKLib/dcmtk/dcmjpeg/djdecode.h"

@implementation DCMImgShow


// DCMTK 支持的类型 LS 未压缩
// 2000 等一些都不支持

-(void)getImgDataFileName:(NSString *)fileName withImgisInverse:(BOOL)isInverse withBlock:(dcmReturn)dicom{
    
  
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"dcm"];
    const char *fileNameStr = [filePath cStringUsingEncoding:NSASCIIStringEncoding];
    
    DcmFileFormat *dcmFileFormat = new DcmFileFormat();
    OFCondition status = dcmFileFormat->loadFile(fileNameStr);
    
    if (status.good()) {
        OFString patientName;
        DcmDataset *dcmDataset = dcmFileFormat->getDataset();
        OFCondition condition = dcmDataset->findAndGetOFString(DCM_PatientName,
                                                               patientName);
        if (condition.good()) {
            NSLog(@"pat name %s", patientName.c_str());
        } else {
            NSLog(@"condition. BAD");
        }
        
        
        const char *transferSyntax;
        DcmMetaInfo *dcmMetaInfo = dcmFileFormat->getMetaInfo();
        OFCondition transferSyntaxOfCondition = dcmMetaInfo->findAndGetString(
                                                                              DCM_TransferSyntaxUID, transferSyntax);
        NSLog(@"transferSyntaxOfCondition  %s", transferSyntaxOfCondition.text());
        NSLog(@"transferSyntax  %s", transferSyntax);
        
        // 获得当前的窗宽 窗位
        
        Float64 windowCenter;
        dcmDataset->findAndGetFloat64(DCM_WindowCenter, windowCenter);
        NSLog(@"windowCenter %f", windowCenter);
        
        Float64 windowWidth;
        dcmDataset->findAndGetFloat64(DCM_WindowWidth, windowWidth);
        NSLog(@"windowWidth %f", windowWidth);
        
        E_TransferSyntax xfer = dcmDataset->getOriginalXfer();
        NSLog(@"E_TransferSyntax %d", xfer);
        
         const char * model;
        dcmDataset->findAndGetString(DCM_Modality, model);
        
        NSLog(@"-------------Model: %s",model);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
        NSString *pathCache = [paths objectAtIndex:0];
        NSLog(@"----------Cache:---%@",pathCache);
        
       
        // Dicom
        DicomImage *m_dcmImage = NULL;
        if (strcmp(transferSyntax, "1.2.840.10008.1.2.4.70") == 0) {
            
            DJDecoderRegistration::registerCodecs();
            OFCondition chooseOfCondition = dcmDataset->chooseRepresentation(
                                                                             EXS_LittleEndianExplicit, NULL);
            
            m_dcmImage = new DicomImage((DcmObject *) dcmDataset,
                                        xfer); //利用dataset生成DicomImage，需要上面的解压方法；
            DJDecoderRegistration::cleanup();
            
        }else if (strcmp(transferSyntax, "1.2.840.10008.1.2.4.80") == 0){
            
            // LS 解码器
            DJLSDecoderRegistration::registerCodecs();
            OFCondition chooseOfCondition = dcmDataset->chooseRepresentation(
                                                                             EXS_LittleEndianExplicit, NULL);
           
//            if (dcmDataset->canWriteXfer(EXS_LittleEndianExplicit)) {
//                OFCondition ofCondition = dcmFileFormat->saveFile(fileNameSave,
//                                                                  EXS_LittleEndianExplicit);
//                
//                if (ofCondition.good()) {
//                    NSLog(@"---------------保存成功----------------");
//                    NSLog(@"---------------------保存成功时间----%@",[self getTimeNow]);
//                }else{
//                    NSLog(@"-------------------Save Fail ------------------");
//                }
//            }
            
            m_dcmImage = new DicomImage((DcmObject *) dcmDataset,
                                        xfer); //利用dataset生成DicomImage，需要上面的解压方法；
            DJLSDecoderRegistration::cleanup();
            
        }else{
//            // LS 解码器
//            DJLSDecoderRegistration::registerCodecs();
//            OFCondition chooseOfCondition = dcmDataset->chooseRepresentation(
//                                                                             EXS_LittleEndianExplicit, NULL);
            
            m_dcmImage = new DicomImage((DcmObject *) dcmDataset,
                                        xfer); //利用dataset生成DicomImage，需要上面的解压方法；
//            DJLSDecoderRegistration::cleanup();
        }
        long height = m_dcmImage->getHeight();
        long width = m_dcmImage->getWidth();
        long depth = m_dcmImage->getDepth();
        
        long size = m_dcmImage->getOutputDataSize(8);
        m_dcmImage->setWindow(windowCenter, windowWidth);
        NSLog(@"png height %ld ", height);
        NSLog(@"png width %ld ", width);
        NSLog(@"png depth %ld ", depth);
        NSLog(@"png size %ld ", size);
        NSLog(@"int size %ld",sizeof(int));

        unsigned char *pixelData = (unsigned char *) (m_dcmImage->getOutputData(8, 0, 0));

        long size1 = height * width;
        unsigned char temp = NULL;
        
        int * p = (int *)malloc(width * height * sizeof(int));
//        int *p = new int[size1];
        
       if(strcmp(model,"SC") == 0){
            unsigned char r = NULL;
            unsigned char g = NULL;
            unsigned char b = NULL;
            for (int j = 0; j < size1; ++j) {
                r = pixelData[j * 3] ;
                g = pixelData[j * 3 + 1] ;
                b = pixelData[j * 3 + 2] ;
                p[j] = r  | g << 8 | b << 16 | 0xff000000;
            }
       }else{
           for (int i = 0; i < size1; ++i) {
               temp = pixelData[i];
               p[i] = temp | (temp << 8) | (temp << 16) | 0xff000000;
           }
       }

        if (pixelData != NULL) {
            NSLog(@"pixelData not null");
        }

        NSData *imgData = [NSData dataWithBytes:(Byte *)p length:size1 * sizeof(int)];
        
        // 释放内存
        free(pixelData);
        free(p);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)imgData);
        
        CGImageRef imageRef = CGImageCreate(width,             //width
                                            height,            //height
                                            8,                 //bits per component
                                            32,                //bits per pixel
                                            width*4,           //bytesPerRow
                                            colorSpace,        //colorspace
                                            kCGImageAlphaNone | kCGImageAlphaNoneSkipLast,        //kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder16Little,// bitmap info
                                            provider,               //CGDataProviderRef
                                            NULL,                   //decode
                                            true,                  //should interpolate
                                            kCGRenderingIntentDefault   //intent
                                            );
        
        if (isInverse) {
            UIImage *testImage = [UIImage imageWithCGImage:imageRef];
            
            dicom(testImage, width, height);
            CGImageRelease(imageRef);
            CGDataProviderRelease(provider);
            CGColorSpaceRelease(colorSpace);
            return;
        }
        
        size_t                  bytesPerRow;
        bytesPerRow = CGImageGetBytesPerRow(imageRef);
        
        CFDataRef   data;
        UInt8*      buffer;
        data = CGDataProviderCopyData(provider);
        buffer = (UInt8*)CFDataGetBytePtr(data);
        UIImage *testImage = [UIImage imageWithCGImage:imageRef];
        
        // 返回当前的img 数据
        dicom(testImage, width, height);
        CGImageRelease(imageRef);
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorSpace);
        CFRelease(data);
    }
}




@end
