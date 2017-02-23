//
//  WheelFlavor.h
//  CoffeTastersIOS
//
//  Created by Ettore Luglio on 11/27/16.
//  Copyright © 2016 Tamadrum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelFlavor : UIView

- (CGPoint) getCoordenadas:(CGPoint) centro comRaio:(int) raio eAngulo:(double) angulo;
- (void) desenhaRoda:(CGContextRef) context comCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio;
- (void) desenhaCirculosPequenos:(CGContextRef) context conCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio;
- (void) desenhaLinhas: (CGContextRef) context comCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio;
- (void) escreveTexto: (NSString*) s eCentro:(CGPoint) centro comRaio:(int) raio angulo:(double) valor;
- (void) desenhaGrafico: (CGContextRef) context comCanvas:(CGRect) canvas eCentro:(CGPoint) centro comRaio:(int) raio;
@end
