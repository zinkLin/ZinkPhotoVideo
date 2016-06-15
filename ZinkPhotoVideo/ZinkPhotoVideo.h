//
//  PhotoCameraManager.h
//  FJLottery
//
//  Created by ganld on 15/6/8星期一.
//  Copyright (c) 2015年 FuJu Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  获取照片视频。
 *  在info.plist中添加：Localized resources can be mixed 并设置 YES 可解决本地化问题
 */
@interface ZinkPhotoVideo : NSObject

/**********************************************图片**********************************************/
/**
 *  调用相机获取图片
 */
+ (void)zinkShowPhotoFromCameraInController:(UIViewController *)viewController
                                 finish:(void(^)(UIImage *image))finish
                                 cancel:(void(^)())cancel;
/**
 *  从相册获取图片
 */
+ (void)zinkShowPhotoFromLibraryInController:(UIViewController *)viewController
                                  finish:(void(^)(UIImage *image))finish
                                  cancel:(void(^)())cancel;
/**
 *  用户自主选择获取图片
 */
+ (void)zinkShowPhotoWithActionSheetInController:(UIViewController *)vc
                                    complete:(void(^)(UIImage *image))completeBlock
                                      cancel:(void(^)())cancelBlock;

/**********************************************视频**********************************************/
/**
 *  调用相机获取视频
 */
+ (void)zinkShowVideoFromCameraInController:(UIViewController *)viewController
                                 finish:(void(^)(NSURL *url))finish
                                 cancel:(void(^)())cancel;
/**
 *  从相册获取视频
 */
+ (void)zinkShowVideoFromLibraryInController:(UIViewController *)viewController
                                  finish:(void(^)(NSURL *url))finish
                                  cancel:(void(^)())cancel;
/**
 *  用户自主选择获取视频
 */
+ (void)zinkShowVideoWithActionSheetInController:(UIViewController *)vc
                                    complete:(void(^)(NSURL *url))completeBlock
                                      cancel:(void(^)())cancelBlock;



@end
