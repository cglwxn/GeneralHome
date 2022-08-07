//
//  SouFunUISTDSIZE.h
//  SouFun
//
//  Created by 吴瑞就 on 17-03-07.
//  功能:UI界面尺寸、颜色、字体大小宏定义


/*
说明:8.4.0开始使用的宏分为两类
 一:颜色类
    格式:STR_功能_色值_颜色描述    如:STR_CONFIGURE_df3031_RED
        STR             头
        CONFIGURE       功能(配置:CONFIGURE     文字主题色:TEXTCOLOR)
        df3031          色值
        RED             颜色描述
 
 二:字号和行间距类:
    格式:STR_功能_数值            如:STR_FONTSIZE_20
        STR             头
        FONTSIZE        功能(字号:FONTSIZE   行间距:VERTICALSPACING)
        20              数值

*/



#pragma mark ------------   8.4.0版本前颜色宏定义   ------------
#define STR_MAIN_COLOR      @"#df3031"  //主题色
#define STR_BLUE_COLOR      @"#6c9cc6"  //主蓝色
#define STR_LINE_COLOR      @"#e0e0e0"  //间隔线
#define STR_NAVBG_COLOR     @"#f9f9f9"  //导航栏背景色
#define STR_NAVTITLE_COLOR  @"#333333"  //导航栏title的颜色
#define STR_NAVBAR_COLOR    @"#666666"  // 导航栏bar的颜色



//=============================8.4.0改版本新增部分=============================
#pragma mark ------------   8.4.0改版颜色设定  ------------
#pragma mark ------------   配置颜色  CONFIGURE ------------
/*
 配置颜色---->主要用于各种控件:按钮、标签、view等等之类的颜色配置设置，多用于列表及详情页的标签及按钮的背景颜色及边框颜色设置
 */
#define STR_CONFIGURE_df3031_RED            @"#df3031"//浅红
#define STR_CONFIGURE_ff8000_SAFFRON        @"#ff8000"//桔黄
#define STR_CONFIGURE_606668_DARKGRAY       @"#606668"//深灰
#define STR_CONFIGURE_c4c9ca_LIGHTGRAY      @"#c4c9ca"//浅灰－－见于浅灰按钮
#define STR_CONFIGURE_fd8181_LIGHTRED       @"#fd8181"//淡红－－见于浅红按钮
#define STR_CONFIGURE_ffffff_WHITE          @"#ffffff"//白－－－见于白底按钮
#define STR_CONFIGURE_fafafa_KUAISAIGRAY    @"#fafafa"//快筛灰－－－见于快筛及家居用到

#define STR_CONFIGURE_394043_DARKBLACK      @"#394043"//深黑色
#define STR_CONFIGURE_999d9e_GRAY           @"#999d9e"//灰色
#define STR_CONFIGURE_e2e6e7_LIGHTGRAY      @"#e2e6e7"//弱灰色
#define STR_CONFIGURE_7d9cb2_BLUE           @"#7d9cb2"//蓝色
#define STR_CONFIGURE_67983b_GREEN          @"#67983b"//绿色


#pragma mark ------------   分割线颜色:浅灰  ------------
/*
 分割线浅灰---->主要用于各种CELL、详情页、或用于分割各板块内部小分块的线条；适合于1像素的线条；禁止给文字或控件设值
 */
#define STR_CONFIGURE_eeeeee_CUTOFFRULEGRAY   @"#eeeeee"//分割线浅灰



#pragma mark ------------   分割条颜色:浅灰  ------------
/*
 分割条浅灰---->主要用于详情页在模块与模块之间的大分割；适合于14像素或7像素的灰条；禁止给文字或控件设值
 */
#define STR_CONFIGURE_f0f0f0_SPLITERGRAY   @"#f0f0f0"//分割条浅灰



#pragma mark ------------   大面积背景颜色:浅灰  ------------
/*
 大面积背景颜色浅灰---->主要用于页面背景、或者大的View之类的控件；主用于背景类:如列表CELL
 */
#define STR_CONFIGURE_f7f7f7_BACKGROUNDGRAY   @"#f7f7f7"//大面积背景颜色浅灰:列表CELL


#pragma mark ------------   大面积背景颜色:CELL点击灰  ------------
/*
 大面积点击背景颜色浅灰---->主要用于页面背景、或者大的View之类的控件；主用于背景类:如列表点击CELL
 */
#define STR_CONFIGURE_ededed_BACKGROUNDGRAY   @"#ededed"//大面积点击背景颜色灰列表点击CELL



#pragma mark ------------   文字主题色  TEXTCOLOR    ------------
/*
 文字主题色---->只能用于设定字体颜色，禁止用来给背景或控件颜色设值，多用于列表及详情页的标签及按钮的字体颜色设置
 */
#define STR_TEXTCOLOR_394043_DARKBLACK      @"#394043"//深黑色－－见于标题及主色调
#define STR_TEXTCOLOR_606668_DARKGRAY       @"#606668"//深灰色
#define STR_TEXTCOLOR_999d9e_GRAY           @"#999d9e"//灰色－－－见于列表cell的副行设定
#define STR_TEXTCOLOR_c4c9ca_FRENCHGRAY     @"#c4c9ca"//浅灰色－－见于日期设定
#define STR_TEXTCOLOR_e2e6e7_LIGHTGRAY      @"#e2e6e7"//弱灰色
#define STR_TEXTCOLOR_7d9cb2_BLUE           @"#7d9cb2"//蓝色－－－见于可跳转链接文字
#define STR_TEXTCOLOR_67983b_GREEN          @"#67983b"//绿色－－－见于环比下降使用的色值
#define STR_TEXTCOLOR_df3031_RED            @"#df3031"//红色－－－见于红色价格设定
#define STR_TEXTCOLOR_fd8181_LIGHTRED       @"#fd8181"//浅红色－－见于在售状态或白底按钮的浅红色字体
#define STR_TEXTCOLOR_ff8000_SAFFRON        @"#ff8000"//桔黄色
#define STR_TEXTCOLOR_ffffff_WHITE          @"#ffffff"//白色－－－见于红色按钮的白色标题

#pragma mark ------------   文字字体大小  FONTSIZE    ------------
/*
 文字字体大小---->多用于设置LABEL、按钮之类的文字大小，禁止用于行间距、frame之类的设置
 */

/*
 20号字体---主要见于大标题使用
 */
#define STR_FONTSIZE_20         20

/*
 16号字体---主要见于一个模块或cell中的标题
 */
#define STR_FONTSIZE_16         16

/*
 14号字体---主要用于人名或可跳转的带链接文字
 */
#define STR_FONTSIZE_14         14

/*
 13号字体---主用的红色价格字体
 */
#define STR_FONTSIZE_13         13

/*
 12号字体---副标题或单位
 */
#define STR_FONTSIZE_12         12

/*
 11号字体---小行展示
 */
#define STR_FONTSIZE_11         11

/*
 10号字体---见于特色标签等
 */
#define STR_FONTSIZE_10         10


#pragma mark ------------   文字行间距  VERTICALSPACING  ------------
/*
 文字行间距---->多用于设置LABEL与LABEL之间的距离或头一个LABEL距离边框的距离，禁止用于文字大小、frame之类的设置
 */

/*
 20间距---主用于详情页头个标签与cell开头的距离或是大文本字体标签之间的距离
 */
#define STR_VERTICALSPACING_20         20

/*
 15间距---主用于列表页头个标签与cell开头的距离
 */
#define STR_VERTICALSPACING_15         15

/*
 10间距---主用于列表cell中普通标签与特色标签的距离－－设计改后
 */
#define STR_VERTICALSPACING_10         10

/*
 9间距---主用于列表cell中普通标签与特色标签的距离
 */
#define STR_VERTICALSPACING_9         9

/*
 8间距---主用于列表cell中普通标签之间的距离
 */
#define STR_VERTICALSPACING_8         8

/*
 7间距----这个会出现在单个Label的多行内容中的行间距使用
 */
#define STR_VERTICALSPACING_7         7



//=============================8.4.0改版本新增部分=============================





#pragma mark ------------   1像素说明及定义    ------------
/*
 a、1Point的线在非Retina屏幕则是一个像素，在Retina屏幕上则可能是2个像素（非6plus）或者3个像素（6plus），取决于系统设备的DPI。
 
 b、所以在非6plus屏幕上1像素我们需要当成 1.0/2 = 0.5 来处理。系统绘制的时候再乘上[UIScreen mainScreen].scale得到像素数去绘制。
 
 c、6plus上则需要1.0/3来处理。如果继续用0.5系统绘制时会有0.5像素的问题，系统会采用“antialiasing(反锯齿)”的技术处理，（详见http://www.cnblogs.com/smileEvday/p/iOS_PixelVsPoint.html）。所以6plus上0.5的线宽（即1.5像素）有时候是1像素有时候是2像素，取决于origin.y的不同。
 
 d、因此，有这样的宏。使用时，将所有0.5的替换成KSINGLELINE_WIDTH即可。
 */
#define KSINGLELINE_WIDTH  1.0f/([UIScreen mainScreen].scale)//1像素线宽的宏。




#pragma mark ------------   屏幕尺寸使用  ------------
/*
 取得屏幕可用宽度及高度尺寸,以size类型返回
 */
#define KSCREENSIZE         ([UIScreen mainScreen].applicationFrame.size)  //屏幕可用尺寸

/*
 取得屏幕可用宽度尺寸
 */
#define KSCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)//屏幕可用宽度

/*
 取得屏幕可用高度尺寸
 */
#define KSCREEN_HEIGHT      ([UIScreen mainScreen].applicationFrame.size.height)//屏幕可用高度




#pragma mark ------------   导航栏高度宏  ------------
/*
 导航栏高度宏--->44
 */
#define KSOUFUN_NAV_HEIGHT  44



#pragma mark ------------   底部TAB高度宏  ------------
/*
 底部TAB高度宏--->49;主要用于底部建工具栏或底部浮框高度,特别是用于SouFunContactView这个类
 */
#define KSOUFUN_MAINTAB_HEIGHT 49




#pragma mark ------------   导航栏右侧按钮frame，分icon样式和文字样式两种  ------------
/*
 导航栏右侧按钮frame，分icon样式和文字样式两种
 */
#define RECT_RIGHTBAR_ICON              CGRectMake(0, 0, 30, 30)                    //icon样式
#define RECT_RIGHTBAR_TEXT(LENGTH)      CGRectMake(0, 0, LENGTH * 15 + 13, 32)      //文字样式边框
#define FONT_NAVBAR_RIGHT               [UIFont systemFontOfSize:15.0f]             //文字样式大小




#pragma mark ------------   导航栏上展示搜索框相关frame，分是否展示rightBarButton两种  ------------
/*
 导航栏上展示搜索框相关frame，分是否展示rightBarButton两种
 */
#define RECT_TITLEVIEW              CGRectMake(0, 0, KSCREEN_WIDTH-110, 44)
#define RECT_TITLEVIEW_NORIGHTBAR   CGRectMake(0, 0, KSCREEN_WIDTH-55, 44)

#define RECT_TITLEVIEW_SEARCHBAR \
CGRectMake(-15, 0, KSCREEN_WIDTH-110 + (iPhone5 ? 15 : (iPhone6 ? 10 : (iPhone6Plus ? 5 : 15))), 44)

#define RECT_TITLEVIEW_SEARCHBAR_NORIGHTBAR \
CGRectMake(-15, 0, KSCREEN_WIDTH-55, 44)

#define RECT_TITLEVIEW_SEARCHBAR_NOLEFTBAR \
CGRectMake(0, 0, KSCREENSIZE.width-80+ (iPhone5 ? 15 : (iPhone6 ? 10 : (iPhone6Plus ? 5 : 15))), 44)

#define FangiPhoneDEVICE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)
#define FangIOS11DEVICE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

//iPoneX相关部分宏定义
#define K_iPhoneX_BOTTOMHEIGHT (FangiPhoneXSeries?34:0)
#define K_NavHeightAndStatusBarHeight (FangiPhoneXSeries?(44+44):(20+44))
#define K_StatusBarHeight (FangiPhoneXSeries?44:20)


#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO)


#define IOS9DEVICE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS10DEVICE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS11DEVICE @available(iOS 11.0, *)
#define iOS_14 @available(iOS 14, *)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 宏名“SFSTR”:对象空处理宏;
 功能:处理对象是否为nil,如果为nil返回@"";不为nil则是什么就返回什么
 另:此宏定义的   最早用意  是用来判断 "字符串是否为nil的处理宏"
 但由于大家用法不严谨造成"字典"、"数组"、“NSDATE”等类型都用此宏来判断
 */
#define SFSTR(string) string == nil?@"":string//对象空处理宏


/**
 宏名“SFSTRNULL”:字符串为nil或字符串null、NULL、(null)、(NULL)处理宏;
 功能:处理字符串是否为nil或字符串null、NULL、(null)、(NULL),如果是返回@"";否则是什么就返回什么
 注:此宏不能用来处理非字符串类型
 如果直接传入非字符串如：NSArray等会报红编译不过
 
 如果间接传入如：SFSTRNULL([dict objectForKey:@"key1"])－－－[dict objectForKey:@"key1"]取出的是NSArray
 不管字典取出的是否有数据都会返回@“”－－－－－这一点请大家注意，这个宏只对字符串管用
 －－－
 －－－－－－只处理字符串－－－－－
 －－－
 */
#define SFSTRNULL(string) (string == nil || ![string isKindOfClass:[NSString class]] || [string isEqualToString:@"null"]|| [string isEqualToString:@"NULL"]|| [string isEqualToString:@"(null)"]|| [string isEqualToString:@"(NULL)"])?@"":string//字符串容错宏

#define STRValid(string) string == nil || string.length == 0 //字符串是否有效

//
////用于“房天下”及“房天下网”APP的不同设置
//#if defined (FANGPRO)
//#define SOUFUNBAIDUKEY @"EoZsW9CjGkbSjBXKazCwVI7o8uaU6eBa"//百度地图KEY
//#define SOUFUNUMMOBKEY @"5983d7e79f06fd32b600048d"//友盟KEY
//#define SOUFUNGAIKEY @"UA-24140496-29"//GA统计KEY
//#define SOUFUNBUNDLEID @"com.soufun.fang"//代码引用的bundleid
//#define SOUFUNSHARELOGO @"Fanglogo.jpg"//分享Fanglogo.jpg
//#define SOUFUNWXAPPID @"wx642641432a7ff584"//微信APPID
//#define SOUFUNWXAPPSECRET @"13d2bb31ad596692acd72cbb99bf754b"//微信AppSecret
//#define SOUFUNTENCENTOPENAPPID @"1106164663"//QQ APPID
//#define SOUFUNAPPSCHEME @"fangpro"//URLSCHEME
//#define SOUFUNPAYPARAS  @"房天下网" //收银台接口
//#define SOUFUNAPPSTOREID  @"1267780260" //AppStore APPID
//
//#else
//#define SOUFUNBAIDUKEY @"n5Gg1G7wwDKGl2gpsU7DKram"//百度地图KEY
//#define SOUFUNUMMOBKEY @"51412bdd5270152f83000009"//友盟KEY
//#define SOUFUNGAIKEY @"UA-24140496-14"//GA统计KEY
//#define SOUFUNBUNDLEID @"com.soufun.SoufunBasic"//代码引用的bundleid
//#define SOUFUNSHARELOGO @"logo.jpg"//分享logo.jpg
//#define SOUFUNWXAPPID @"wxc207cd5f14a013e8"//微信APPID
//#define SOUFUNWXAPPSECRET @"fcdb8b3c3fd9665ecbcc6b8f7c1f24e7"//微信AppSecret
//#define SOUFUNTENCENTOPENAPPID @"100869910"//QQ APPID
//#define SOUFUNAPPSCHEME @"soufun"//URLSCHEME
//#define SOUFUNPAYPARAS @"房天下" //收银台接口
//#define SOUFUNAPPSTOREID  @"413993350" //AppStore APPID
//
//#endif







