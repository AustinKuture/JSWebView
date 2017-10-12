//
//  AKHeader.h
//  AKJSWebViewPicture
//
//  Created by 李亚坤 on 2017/10/12.
//  Copyright © 2017年 TFS. All rights reserved.
//

#ifndef AKHeader_h
#define AKHeader_h


//Main Define
#define SCREEN_ALL [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define FONT_S(s) [UIFont systemFontOfSize:s]
#define FONTS_STYLE(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]
#define FONTS_FAMILY(name,s) [UIFont fontWithName:name size:s]

//打印内容转码成汉字
#ifdef DEBUG
#define MyLog(FORMAT, ...) fprintf(stderr,"[函数名:%s]\n[行号:%d]%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
#else
#define MyLog(...)
#endif

/*
 * 十六进制 (使用时加上前缀0x)
 */
#define COLORS_HEX(s,a) [UIColor colorWithRed:((float)((s & 0xFF0000) >> 16))/255.0 green:((float)((s & 0xFF00) >>8))/255.0 blue:((float)(s & 0xFF))/255.0 alpha:a]

//COLORS
#define GROUNDSAME(n,a) GROUNDCOLOR(n,n,n,a)
#define GROUNDCOLOR(r,g,b,a) [UIColor colorWithRed: r / 255.0 green: g / 255.0 blue: b / 255.0 alpha: a]
#define COLORS_RANDOM(a) GROUNDSAME(arc4random_uniform(255),a)
#define COLORS_SHADOW GROUNDCOLOR(180,189,207,1)

#define COLORS_WHITE [UIColor whiteColor]
#define COLORS_RED [UIColor redColor]
#define COLORS_GREEN [UIColor greenColor]
#define COLORS_BLUE [UIColor blueColor]
#define COLORS_PURPLE [UIColor purpleColor]
#define COLORS_ORANGE [UIColor orangeColor]
#define COLORS_YELLOW [UIColor yellowColor]
#define COLORS_GRAY [UIColor grayColor]
#define COLORS_LIGHTGRAY [UIColor lightGrayColor]
#define COLORS_BLACK [UIColor blackColor]
#define COLORS_DARKGRAY [UIColor darkGrayColor]
#define COLORS_CYAN [UIColor cyanColor]
#define COLORS_MAGENTA [UIColor magentaColor]
#define COLORS_BROWN [UIColor brownColor]
#define COLORS_CLEAR [UIColor clearColor]

//Text Alignment
#define ALIG_CENTER NSTextAlignmentCenter
#define ALIG_LEFT NSTextAlignmentLeft
#define ALIG_RIGHT NSTextAlignmentRight
#define ALIG_NATURAL NSTextAlignmentNatural
#define ALIG_JUSTIFIED NSTextALignmentJustified

//String Random

#define R_N(n) arc4random_uniform(n)
#define STR_RANDOM(S,n,m) [NSString stringWithFormat:@"%@%d",S,R_N(n) + m]

#endif /* AKHeader_h */
