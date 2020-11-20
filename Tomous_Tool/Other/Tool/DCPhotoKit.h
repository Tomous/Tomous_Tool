//
//  DCPhotoKit.h
//  百思不得姐
//
//  Created by 大橙子 on 2019/11/27.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface DCPhotoKit : NSObject
#pragma mark 1、获取自定义的相册
+(PHAssetCollection *)createPHAssetCollection;

#pragma mark 2、保存图片到自定义的相册
+(void)savePhotosToAppPhotoCollection:(UIImage *)saveImage;

#pragma mark 3、保存图片到 相机胶卷相册(单纯的保存图片到相册)
+(void)savePhotosToCameraRollPhotoCollection:(UIImage *)saveImage;
@end

NS_ASSUME_NONNULL_END
