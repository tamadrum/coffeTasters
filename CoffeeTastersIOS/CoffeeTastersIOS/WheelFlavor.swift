//
//  WheelFlavor.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/23/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class WheelFlavor: UIView {
    
    var flavorTorrador:Flavor = Flavor()
    var flavorMedia:Flavor = Flavor()
    var flavorUsuario:Flavor = Flavor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        desenhar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        desenhar()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
//        desenhar()
    }

    override func draw(_ rect: CGRect) {
        let centro = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        var raio:Int = Int(centro.y/2)
        if ( centro.x > centro.y ) {
            raio = Int(centro.x/2)
        }
    
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(CGFloat(0.5))
            context.setStrokeColor(UIColor.black.cgColor)
            
            desenhaLinhas(context: context, canvas:frame, centro:centro, raio:raio)
            
            escreveTexto(texto: "Salgado", centro:centro, raio:raio, angulo:0)
            escreveTexto(texto: "Especiarias", centro:centro, raio:raio, angulo:22.5)
            escreveTexto(texto: "Floral", centro:centro, raio:raio, angulo:45)
            escreveTexto(texto: "Azedo", centro:centro, raio:raio, angulo:67.5)
            escreveTexto(texto: "Doce", centro:centro, raio:raio, angulo:90)
            escreveTexto(texto: "Nozes", centro:centro, raio:raio, angulo:112.5)
            escreveTexto(texto: "Cereais", centro:centro, raio:raio, angulo:135)
            escreveTexto(texto: "Encorpado", centro:centro, raio:raio, angulo:157.5)
            escreveTexto(texto: "Herbal", centro:centro, raio:raio, angulo:180)
            escreveTexto(texto: "Amargo", centro:centro, raio:raio, angulo:202.5)
            escreveTexto(texto: "Defumado", centro:centro, raio:raio, angulo:225)
            escreveTexto(texto: "Caramelo", centro:centro, raio:raio, angulo:247.5)
            escreveTexto(texto: "Chocolate", centro:centro, raio:raio, angulo:270)
            escreveTexto(texto: "Frutas com Caroço", centro:centro, raio:raio, angulo:292.5)
            escreveTexto(texto: "Frutas Cítricas", centro:centro, raio:raio, angulo:315)
            escreveTexto(texto: "Frutas Vermelhas", centro:centro, raio:raio, angulo:337.5)
            
            //            desenhaImagem(imagem: "Salgado.png", context: context, centro: centro, raio: raio, angulo: 0)
            //            desenhaImagem(imagem: "Salgado.png", context: context, centro:centro, raio:raio, angulo:0)
            //            desenhaImagem(imagem: "Especiarias.png", context: context, centro:centro, raio:raio, angulo:22.5)
            //            desenhaImagem(imagem: "Floral.png", context: context, centro:centro, raio:raio, angulo:45)
            //            desenhaImagem(imagem: "Azedo.png", context: context, centro:centro, raio:raio, angulo:67.5)
            //            desenhaImagem(imagem: "Doce.png", context: context, centro:centro, raio:raio, angulo:90)
            //            desenhaImagem(imagem: "Nozes.png", context: context, centro:centro, raio:raio, angulo:112.5)
            //            desenhaImagem(imagem: "Cereais.png", context: context, centro:centro, raio:raio, angulo:135)
            //            desenhaImagem(imagem: "Encorpado.png", context: context, centro:centro, raio:raio, angulo:157.5)
            //            desenhaImagem(imagem: "Herbal.png", context: context, centro:centro, raio:raio, angulo:180)
            //            desenhaImagem(imagem: "Amargo.png", context: context, centro:centro, raio:raio, angulo:202.5)
            //            desenhaImagem(imagem: "Defumado.png", context: context, centro:centro, raio:raio, angulo:225)
            //            desenhaImagem(imagem: "Caramelo.png", context: context, centro:centro, raio:raio, angulo:247.5)
            //            desenhaImagem(imagem: "Chocolate.png", context: context, centro:centro, raio:raio, angulo:270)
            //            desenhaImagem(imagem: "Frutas com Caroço.png", context: context, centro:centro, raio:raio, angulo:292.5)
            //            desenhaImagem(imagem: "Frutas Cítricas.png", context: context, centro:centro, raio:raio, angulo:315)
            //            desenhaImagem(imagem: "Frutas Vermelhas.png", context: context, centro:centro, raio:raio, angulo:337.5)
            
            desenhaRoda(context: context, canvas:frame, centro:centro, raio:raio)
            desenhaCirculosPequenos(context: context, canvas:frame, centro:centro, raio:raio)
            context.strokePath()
            
            desenhaGrafico(context: context, canvas:frame, centro:centro, raio:raio, flavor:flavorUsuario, cor: UIColor.black)
            desenhaGrafico(context: context, canvas:frame, centro:centro, raio:raio, flavor:flavorMedia, cor: UIColor.blue)
            desenhaGrafico(context: context, canvas:frame, centro:centro, raio:raio, flavor:flavorTorrador, cor: UIColor.brown)
        }

    }
    
    func getCoordenadas(centro: CGPoint, raio: Int, angulo: Double) -> CGPoint {
        let x = centro.x + (CGFloat) (cos(angulo*M_PI/180.0)*Double(raio))
        let y = centro.y - (CGFloat) (sin(angulo*M_PI/180.0)*Double(raio))
        return CGPoint(x:x, y:y)
    }
    
    func desenhaCirculosPequenos(context: CGContext, canvas: CGRect, centro: CGPoint, raio: Int) {
        for i in stride(from: 0, to: raio, by: raio/5) {
            for j in stride(from: 0, to: 360, by: 22.5) {
                let p = getCoordenadas(centro: centro, raio: i, angulo: j);
                let rectangle = CGRect(x: p.x-2, y: p.y-2, width: 4, height: 4)
                context.addEllipse(in: rectangle)
            }
        }
    }
    
    func desenhaLinhas(context: CGContext, canvas: CGRect, centro: CGPoint, raio: Int) {
        for i in stride(from: 0, to: 360, by: 22.5) {
            let p = getCoordenadas(centro: centro, raio: raio, angulo: i)
            context.move(to: centro)
            context.addLine(to: p)
        }
    }
    
    func desenhaRoda(context: CGContext, canvas: CGRect, centro: CGPoint, raio: Int) {
        let passo = CGFloat(raio/5)
        
        context.addEllipse(in: CGRect(x: centro.x-passo*5, y: centro.y-passo*5, width: passo*10, height: passo*10))
        
        context.addEllipse(in: CGRect(x: centro.x-passo*4, y: centro.y-passo*4, width: passo*8,  height: passo*8))
        context.addEllipse(in: CGRect(x: centro.x-passo*3, y: centro.y-passo*3, width: passo*6,  height: passo*6))
        context.addEllipse(in: CGRect(x: centro.x-passo*2, y: centro.y-passo*2, width: passo*4,  height: passo*4))
        context.addEllipse(in: CGRect(x: centro.x-passo,   y: centro.y-passo,   width: passo*2,  height: passo*2))
    }
    
    func escreveTexto(texto: String, centro: CGPoint, raio: Int, angulo: Double){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center;
        
        let font = UIFont(name: "Helvetica-Bold", size:9.0)
        let novoCentro = CGPoint(x: centro.x-20, y: centro.y-5)
        let novoRaio = raio + 25
        let origem = getCoordenadas(centro: novoCentro, raio: novoRaio, angulo: angulo)

        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: paragraphStyle]
        
        let myString: NSString = texto as NSString
        let size: CGSize = myString.size(attributes: attributes)
        
        let textRect = CGRect(x: origem.x, y: origem.y, width: size.width, height: size.height);
        
        myString.draw(in: textRect, withAttributes: attributes)
    }
    
    func desenhaImagem(imagem: String, context: CGContext, centro: CGPoint, raio: Int, angulo: Double){
        if let imageUI = UIImage(named:imagem) {
            if let image = imageUI.cgImage {
                let ponto = getCoordenadas(centro: centro, raio: raio, angulo: angulo)
                
                let rect = CGRect(x: ponto.x - CGFloat(image.width/2), y: ponto.y - CGFloat(image.height), width: CGFloat(image.width), height: CGFloat(image.height))
                
                context.draw(image, in: rect)
            }
        }
    }

    func desenhaGrafico (context: CGContext, canvas: CGRect, centro: CGPoint, raio: Int, flavor: Flavor, cor: UIColor) {
        
        print("raio: \(raio)")
        context.setLineWidth(2.0)
        context.setStrokeColor(cor.cgColor)
        let doce = getCoordenadas(centro: centro, raio: flavor.doce*raio/10,  angulo:90)
        let azedo = getCoordenadas(centro: centro, raio:flavor.azedo*raio/10, angulo:67.5)
        let floral = getCoordenadas(centro: centro, raio:flavor.floral*raio/10, angulo:45)
        let especiarias = getCoordenadas(centro: centro, raio:flavor.especiarias*raio/10, angulo:22.5)
        let salgado = getCoordenadas(centro: centro, raio:flavor.salgado*raio/10, angulo:0)
        let frutasVermelhas = getCoordenadas(centro: centro, raio:flavor.frutasVermelhas*raio/10, angulo:337.5)
        let frutasCitrico = getCoordenadas(centro: centro, raio:flavor.frutasCitrico*raio/10, angulo:315)
        let frutasCaroco = getCoordenadas(centro: centro, raio:flavor.frutasCaroco*raio/10, angulo:292.5)
        let chocolate = getCoordenadas(centro: centro, raio:flavor.chocolate*raio/10, angulo:270)
        let caramelo = getCoordenadas(centro: centro, raio:flavor.caramelo*raio/10, angulo:247.5)
        let defumado = getCoordenadas(centro: centro, raio:flavor.defumado*raio/10, angulo:225)
        let amargo = getCoordenadas(centro: centro, raio:flavor.amargo*raio/10, angulo:202.5)
        let herbal = getCoordenadas(centro: centro, raio:flavor.herbal*raio/10, angulo:180)
        let encorpado = getCoordenadas(centro: centro, raio:flavor.encorpado*raio/10, angulo:157.5)
        let cereais = getCoordenadas(centro: centro, raio:flavor.cereais*raio/10, angulo:135)
        let nozes = getCoordenadas(centro: centro, raio:flavor.nozes*raio/10, angulo:112.5)
        
        context.move(to: doce)
        context.addLine(to: azedo)
        context.addLine(to: floral)
        context.addLine(to: especiarias)
        context.addLine(to: salgado)
        context.addLine(to: frutasVermelhas)
        context.addLine(to: frutasCitrico)
        context.addLine(to: frutasCaroco)
        context.addLine(to: chocolate)
        context.addLine(to: caramelo)
        context.addLine(to: defumado)
        context.addLine(to: amargo)
        context.addLine(to: herbal)
        context.addLine(to: encorpado)
        context.addLine(to: cereais)
        context.addLine(to: nozes)
        context.addLine(to: doce)
        context.strokePath()
    }
}

