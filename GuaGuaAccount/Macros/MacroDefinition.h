

#ifndef MacroDefinition_h
#define MacroDefinition_h

#pragma mark - 获取设备大小

//NavBar高度
//#define NavigationBar_Height 44
////获取屏幕 宽度、高度
//#define WIDTH  self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height
//#define ContentViewH (ScreenHeight-20-44-49)
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

/**
 *  将enum转换成string。
 *  注：只是普通的转换
 *
 *  @param enum
 *
 *  @return
 */
#define enumToString(enum) [NSString stringWithFormat:@"%d", enum]

//弱引用
#define GGWeakSelfDefine __weak typeof(self) weakSelf = self;
#define GGWeakSelf weakSelf

#endif
