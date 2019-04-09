//
//  NSString+utils.m
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/7.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import "NSString+utils.h"
#import <NSData+MD5Digest.h>

@implementation NSString (utils)

- (NSString *)md5 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[data MD5HexDigest] copy];
}

- (CGFloat)widthOfSingleLineWithAttributes:(NSDictionary<NSAttributedStringKey,id> *)attributes {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    CGFloat width = [attributedString boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.width;
    return width;
}

- (CGSize)boundingRectWithSize:(CGSize)size
                          font:(UIFont*)font
                   lineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    if (lineSpacing > 0) {
        [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    }
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self]) {
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    return rect.size;
}

- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++) {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }     return NO;
}


- (NSAttributedString *)htmlStringAttributed {
    NSString *string = [NSString autoWebAutoImageSizeForEtzy:self];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithData:[string  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    [attributedText addAttributes:@{NSForegroundColorAttributeName : [UIColor color666],
                                    NSFontAttributeName            : [UIFont systemFontOfSize:15],
                                    NSKernAttributeName            : @2,
                                    NSParagraphStyleAttributeName  : paragraphStyle
                                    } range:NSMakeRange(0, attributedText.length)];
    return attributedText;
}

+ (NSString *)autoWebAutoImageSize:(NSString *)html{
    
    NSString * regExpStr = @"<img\\s+.*?\\s+(style\\s*=\\s*.+?\")";

    NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches=[regex matchesInString:html
                                    options:0
                                      range:NSMakeRange(0, [html length])];
    
    
    NSMutableArray * mutArray = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSString* group1 = [html substringWithRange:[match rangeAtIndex:1]];

        [mutArray addObject: group1];
    }
    
    NSUInteger len = [mutArray count];
    for (int i = 0; i < len; ++ i) {
        html = [html stringByReplacingOccurrencesOfString:mutArray[i] withString: @"style=\"width:90%; height:auto;\""];
    }
    
    return html;
}

+ (NSString *)autoWebAutoImageSizeForEtzy:(NSString *)html{
    
    NSString * regExpStr = @"<img\\s+.*?\\s+style";

    NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches=[regex matchesInString:html
                                    options:0
                                      range:NSMakeRange(0, [html length])];
    
    if (matches.count == 0) {
        html = [html stringByReplacingOccurrencesOfString:@"<img" withString: @"<img style=\"width:45%; height:auto;\""];
        NSLog(@"%@", html);
        return html;
    }
    return html;
}

+ (NSString *)stringWithDuration:(NSInteger)duration {
    if (duration < 0) {
        return @"";
    }
    if (duration == 0) {
        return @"00:00";
    }
    return [NSString stringWithFormat:@"%02ld:%02ld", duration / 60, duration % 60];
}

+ (NSString *)stringWithPlayCount:(NSInteger)playCount {
    if (playCount >= pow(10, 4)) {
        return  [NSString stringWithFormat:@"%.2f万", playCount / pow(10, 4)];
    } else {
        return [NSString stringWithFormat:@"%.0f", playCount / 1.0];
    }
}

@end
