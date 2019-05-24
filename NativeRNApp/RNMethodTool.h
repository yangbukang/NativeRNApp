//
//  RNMethodTool.h
//  NativeRNApp
//
//  Created by mxy on 2018/11/21.
//

#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridge.h>
NS_ASSUME_NONNULL_BEGIN

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

//#define SINGLETON_FOR_CLASS(className) \
//\
//+ (className *)shared##className { \
//static className *shared##className = nil; \
//static dispatch_once_t onceToken; \
//dispatch_once(&onceToken, ^{ \
//shared##className = [[self alloc] init]; \
//}); \
//return shared##className; \
//}

@interface RNMethodTool : RCTEventEmitter<RCTBridgeModule>

//单例
//SINGLETON_FOR_HEADER(RNMethodTool)

+(void)emitMethod;
//  RN那边做了监听，这个就是调用 RN 方法，弹出 RN 系统提示框
@end


NS_ASSUME_NONNULL_END
