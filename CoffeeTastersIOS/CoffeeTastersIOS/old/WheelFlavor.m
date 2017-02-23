//
//  WheelFlavor.m
//  CoffeTastersIOS
//
//  Created by Ettore Luglio on 11/27/16.
//  Copyright © 2016 Tamadrum. All rights reserved.
//

#import "WheelFlavor.h"
#import "Flavor.h"

@implementation WheelFlavor

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint centro = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    int raio = centro.y/2;
    if ( centro.x > centro.y ) raio = centro.x/2;
    
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    [self desenhaLinhas:context comCanvas:rect eCentro:centro comRaio:raio];
    
    [self escreveTexto:@"SALTY" eCentro:centro comRaio:raio angulo:0];
    [self escreveTexto:@"SPICY" eCentro:centro comRaio:raio angulo:22.5];
    [self escreveTexto:@"FLORAL" eCentro:centro comRaio:raio angulo:45];
    [self escreveTexto:@"SOUR" eCentro:centro comRaio:raio angulo:67.5];
    [self escreveTexto:@"SWEET" eCentro:centro comRaio:raio angulo:90];
    [self escreveTexto:@"LINGER" eCentro:centro comRaio:raio angulo:112.5];
    [self escreveTexto:@"CLEAN" eCentro:centro comRaio:raio angulo:135];
    [self escreveTexto:@"BODY" eCentro:centro comRaio:raio angulo:157.5];
    [self escreveTexto:@"SAVORY" eCentro:centro comRaio:raio angulo:180];
    [self escreveTexto:@"BITTER" eCentro:centro comRaio:raio angulo:202.5];
    [self escreveTexto:@"SMOKY" eCentro:centro comRaio:raio angulo:225];
    [self escreveTexto:@"CARAMEL" eCentro:centro comRaio:raio angulo:247.5];
    [self escreveTexto:@"CHOCOLATE" eCentro:centro comRaio:raio angulo:270];
    [self escreveTexto:@"STONE" eCentro:centro comRaio:raio angulo:292.5];
    [self escreveTexto:@"CITRUS" eCentro:centro comRaio:raio angulo:315];
    [self escreveTexto:@"BERRY" eCentro:centro comRaio:raio angulo:337.5];
    
    [self desenhaRoda:context comCanvas:rect eCentro:centro comRaio:raio];
    
    [self desenhaCirculosPequenos:context conCanvas:rect eCentro:centro comRaio:raio];
    CGContextStrokePath(context);

    [self desenhaGrafico:context comCanvas:rect eCentro:centro comRaio:raio];
}

- (CGPoint) getCoordenadas:(CGPoint) centro comRaio:(int) raio eAngulo:(double) angulo
{
    int x = centro.x + (int) (cos(angulo*M_PI/180)*raio);
    int y = centro.y - (int) (sin(angulo*M_PI/180)*raio);
    return CGPointMake(x, y);
}

- (void) desenhaRoda:(CGContextRef) context comCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio
{
    int passo = raio/5;
    
    CGRect rectangle = CGRectMake(centro.x-passo*5,centro.y-passo*5,passo*10,passo*10);
    CGContextAddEllipseInRect(context, rectangle);
    
    rectangle = CGRectMake(centro.x-passo*4,centro.y-passo*4,passo*8,passo*8);
    CGContextAddEllipseInRect(context, rectangle);
    
    rectangle = CGRectMake(centro.x-passo*3,centro.y-passo*3,passo*6,passo*6);
    CGContextAddEllipseInRect(context, rectangle);
    
    rectangle = CGRectMake(centro.x-passo*2,centro.y-passo*2,passo*4,passo*4);
    CGContextAddEllipseInRect(context, rectangle);
    
    rectangle = CGRectMake(centro.x-passo,centro.y-passo,passo*2,passo*2);
    CGContextAddEllipseInRect(context, rectangle);
    
}

- (void) desenhaCirculosPequenos:(CGContextRef) context conCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio
{
    for ( double i = 0 ; i <= raio; i = i + raio/5 ) {
        for ( double j = 0 ; j < 360 ; j += 22.5 ) {
            CGPoint p = [self getCoordenadas:centro comRaio:i eAngulo:j];
            CGRect rectangle = CGRectMake(p.x-2,p.y-2, 4, 4);
            CGContextAddEllipseInRect(context, rectangle);
        }
    }
}

- (void) desenhaLinhas: (CGContextRef) context comCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio
{
    for ( double j = 0 ; j < 360 ; j+=22.5 ) {
        CGPoint p = [self getCoordenadas:centro comRaio:raio eAngulo:j];
        CGContextMoveToPoint(context, centro.x, centro.y);
        CGContextAddLineToPoint(context, p.x, p.y);
    }
}

- (void) escreveTexto: (NSString*) s eCentro:(CGPoint) centro comRaio:(int) raio angulo:(double) valor
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont* font = [UIFont fontWithName:@"Helvetica-Bold" size:9.0];
    
    centro.x -= 20;
    centro.y -= 5;
    raio += 25;
    
    CGPoint origem = [self getCoordenadas:centro comRaio:raio eAngulo:valor];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGSize size = [s sizeWithAttributes:attributes];
    
    CGRect textRect = CGRectMake(origem.x, origem.y, size.width, size.height);
    
    [s drawInRect:textRect withAttributes:attributes];
}

- (void) desenhaGrafico: (CGContextRef) context comCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio
{
    
    Flavor* f = [Flavor new];
    f.sweet = 20;
    f.sour_tart = 10;
    f.floral = 100;
    f.spicy = 45;
    f.salty = 88;
    f.berry_fruit = 67;
    f.citrus_fruit = 20;
    f.stone_fruit = 34;
    f.chocolate = 30;
    f.caramel = 40;
    f.smoky = 67;
    f.bitter = 33;
    f.savory = 22;
    f.body = 11;
    f.clean = 90;
    f.linger_finish = 100;

    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGPoint sweet = [self getCoordenadas:centro comRaio:[f sweet]*raio/100 eAngulo:90];
    CGPoint sour_tart = [self getCoordenadas:centro comRaio:[f sour_tart]*raio/100 eAngulo:67.5];
    CGPoint floral = [self getCoordenadas:centro comRaio:[f floral]*raio/100 eAngulo:45];
    CGPoint spicy = [self getCoordenadas:centro comRaio:[f spicy]*raio/100 eAngulo:22.5];
    CGPoint salty = [self getCoordenadas:centro comRaio:[f salty]*raio/100 eAngulo:0];
    CGPoint berry = [self getCoordenadas:centro comRaio:[f berry_fruit]*raio/100 eAngulo:337.5];
    CGPoint citrus = [self getCoordenadas:centro comRaio:[f citrus_fruit]*raio/100 eAngulo:315];
    CGPoint stone = [self getCoordenadas:centro comRaio:[f stone_fruit]*raio/100 eAngulo:292.5];
    CGPoint chocolate = [self getCoordenadas:centro comRaio:[f chocolate]*raio/100 eAngulo:270];
    CGPoint caramel = [self getCoordenadas:centro comRaio:[f caramel]*raio/100 eAngulo:247.5];
    CGPoint smoky = [self getCoordenadas:centro comRaio:[f smoky]*raio/100 eAngulo:225];
    CGPoint bitter = [self getCoordenadas:centro comRaio:[f bitter]*raio/100 eAngulo:202.5];
    CGPoint savory = [self getCoordenadas:centro comRaio:[f savory]*raio/100 eAngulo:180];
    CGPoint body = [self getCoordenadas:centro comRaio:[f body]*raio/100 eAngulo:157.5];
    CGPoint clean = [self getCoordenadas:centro comRaio:[f clean]*raio/100 eAngulo:135];
    CGPoint linger = [self getCoordenadas:centro comRaio:[f linger_finish]*raio/100 eAngulo:112.5];
    
    CGContextMoveToPoint(context, sweet.x, sweet.y);
    CGContextAddLineToPoint(context, sour_tart.x, sour_tart.y);
    CGContextAddLineToPoint(context, floral.x, floral.y);
    CGContextAddLineToPoint(context, spicy.x, spicy.y);
    CGContextAddLineToPoint(context, salty.x, salty.y);
    CGContextAddLineToPoint(context, berry.x, berry.y);
    CGContextAddLineToPoint(context, citrus.x, citrus.y);
    CGContextAddLineToPoint(context, stone.x, stone.y);
    CGContextAddLineToPoint(context, chocolate.x, chocolate.y);
    CGContextAddLineToPoint(context, caramel.x, caramel.y);
    CGContextAddLineToPoint(context, smoky.x, smoky.y);
    CGContextAddLineToPoint(context, bitter.x, bitter.y);
    CGContextAddLineToPoint(context, savory.x, savory.y);
    CGContextAddLineToPoint(context, body.x, body.y);
    CGContextAddLineToPoint(context, clean.x, clean.y);
    CGContextAddLineToPoint(context, linger.x, linger.y);
    CGContextAddLineToPoint(context, sweet.x, sweet.y);
    
    CGContextStrokePath(context);
}

@end
