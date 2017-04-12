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

/// Roda de sabores customizada para esta aplicação
class WheelFlavor: UIView {
    
    /// Mostra alerta de opcao clicada
    var mostraAlerta: Bool = false
    var sabores = ["doce", "azedo", "floral", "especiarias", "salgado", "frutas vermelhas", "cítricos", "frutas com caroço", "chocolate", "caramelo", "defumado", "amargo", "herbal", "encorpado", "cereais", "nozes"]
    var indiceSabores: Int = 0
    
    /// **flavorTorrador** é a variavel que conterá a roda de sabores que o torrador fez para o café
    var flavorTorrador:Flavor?
    /// **flavorMédia** é a variavel que conterá a roda de sabores que a média geral avaliou
    var flavorMedia:Flavor?
    /// **flavorUsuario** é a variavel que conterá a roda de sabores que o usuário preencheu
    var flavorUsuario:Flavor?
    // Rects referente a onde as imagens se encontram em ordem
    var images:[CGRect] = []
    
    /// Array de cores para a roda dos sabores
    let cores = [
        WheelFlavor.hexStringToUIColor(hex: "BD183D"), // doce
        WheelFlavor.hexStringToUIColor(hex: "F4CE01"), // azedo
        WheelFlavor.hexStringToUIColor(hex: "EA6164"), // floral
        WheelFlavor.hexStringToUIColor(hex: "75833A"), // especiarias
        WheelFlavor.hexStringToUIColor(hex: "008AC0"), // salgado
        WheelFlavor.hexStringToUIColor(hex: "94386F"), // frutasVermelhas
        WheelFlavor.hexStringToUIColor(hex: "FECF57"), // frutasCítricas
        WheelFlavor.hexStringToUIColor(hex: "F37121"), // frutasCaroco
        WheelFlavor.hexStringToUIColor(hex: "6A331C"), // chocolate
        WheelFlavor.hexStringToUIColor(hex: "C78542"), // caramelo
        WheelFlavor.hexStringToUIColor(hex: "665E4A"), // defumado
        WheelFlavor.hexStringToUIColor(hex: "3D3C3E"), // amargo
        WheelFlavor.hexStringToUIColor(hex: "5C9337"), // herbal
        WheelFlavor.hexStringToUIColor(hex: "D14A28"), // encorpado
        WheelFlavor.hexStringToUIColor(hex: "A8AC46"), // cereais
        WheelFlavor.hexStringToUIColor(hex: "8B560E"), // nozes
        ]

    var raio: Int!
    
    override func draw(_ rect: CGRect) {
        let centro = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        raio = Int(centro.y/2)
        if ( centro.x > centro.y ) {
            raio = Int(centro.x/2)
        }
        self.isUserInteractionEnabled = true
    
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(CGFloat(0.5))
            context.setStrokeColor(UIColor.black.cgColor)
            
            images = [
                desenhaImagem(#imageLiteral(resourceName: "doce"), context: context, centro:centro, raio:(raio+20), angulo:11.25), // doce
                desenhaImagem(#imageLiteral(resourceName: "acido"), context: context, centro:centro, raio:(raio+20), angulo:33.75), // azedo
                desenhaImagem(#imageLiteral(resourceName: "floral"), context: context, centro:centro, raio:(raio+20), angulo:56.25), // floral
                desenhaImagem(#imageLiteral(resourceName: "especiarias"), context: context, centro:centro, raio:(raio+20), angulo:78.75), // especiarias
                desenhaImagem(#imageLiteral(resourceName: "salgado"), context: context, centro:centro, raio:(raio+20), angulo:101.25), // salgado
                desenhaImagem(#imageLiteral(resourceName: "frutasVermelhas"), context: context, centro:centro, raio:(raio+20), angulo:123.75), // frutasVermelhas
                desenhaImagem(#imageLiteral(resourceName: "citrico"), context: context, centro:centro, raio:(raio+20), angulo:146.25), // frutasCitricas
                desenhaImagem(#imageLiteral(resourceName: "frutasCaroco"), context: context, centro:centro, raio:(raio+20), angulo:168.75), // frutasCaroco
                desenhaImagem(#imageLiteral(resourceName: "chocolate"), context: context, centro:centro, raio:(raio+20), angulo:191.25), // chocolate
                desenhaImagem(#imageLiteral(resourceName: "caramelo"), context: context, centro:centro, raio:(raio+20), angulo:213.75), // caramelo
                desenhaImagem(#imageLiteral(resourceName: "defumado"), context: context, centro:centro, raio:(raio+20), angulo:236.25), // defumado
                desenhaImagem(#imageLiteral(resourceName: "amargo"), context: context, centro:centro, raio:(raio+20), angulo:258.75), // amargo
                desenhaImagem(#imageLiteral(resourceName: "herbal"), context: context, centro:centro, raio:(raio+20), angulo:281.25), // herbal
                desenhaImagem(#imageLiteral(resourceName: "encorpado"), context: context, centro:centro, raio:(raio+20), angulo:303.75), // encorpado
                desenhaImagem(#imageLiteral(resourceName: "cereais"), context: context, centro:centro, raio:(raio+20), angulo:326.25), // cereais
                desenhaImagem(#imageLiteral(resourceName: "nozes"), context: context, centro:centro, raio:(raio+20), angulo:348.75), // nozes
            ]
            
            desenhaRoda(context: context, centro:centro, raio:raio)
            //desenhaLinhas(context: context, centro: centro, raio: raio)
            //desenhaCirculosPequenos(context: context, centro: centro, raio: raio)

            context.strokePath()
            
            if let flavor = flavorUsuario {
                desenhaGraficoPreenchido(context: context, centro:centro, raio:raio, flavor:flavor, cores: cores)
            }
            if let flavor = flavorTorrador {
                desenhaGrafico(context: context, centro:centro, raio:raio, flavor:flavor, cor: UIColor.red)
            }
            if let flavor = flavorMedia {
                desenhaGrafico(context: context, centro:centro, raio:raio, flavor:flavor, cor: UIColor.blue)
            }
            
            mostraAlerta(context: context, centro: centro)
        }
    }
    
    func mostraAlerta (context: CGContext, centro: CGPoint) {
        if ( mostraAlerta ) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byTruncatingTail
            paragraphStyle.alignment = .center;
            let font = UIFont(name: "Helvetica-Bold", size:20.0)
            let attributes:[String:Any] = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: paragraphStyle]
            let myString: NSString = sabores[indiceSabores] as NSString
            let size = myString.size(attributes: attributes)
            let textRect = CGRect(x: centro.x-size.width/2, y: centro.y-size.height/2, width: size.width, height: size.height);
            
            drawRoundRect(dimensoes: CGRect(x: centro.x-size.width/2 - 20, y: centro.y-size.height/2 - 10, width: size.width + 40, height: size.height + 20), cor: cores[indiceSabores].cgColor)
            
            myString.draw(in: textRect, withAttributes: attributes)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
//                self.mostraAlerta = false
//                self.setNeedsDisplay()
//            }
        }
    }
    
    func drawRoundRect(dimensoes: CGRect, cor: CGColor) {
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        let clipPath: CGPath = UIBezierPath(roundedRect: dimensoes, cornerRadius: 20).cgPath
        ctx.addPath(clipPath)
        ctx.setFillColor(cor)
        ctx.closePath()
        ctx.fillPath()
        ctx.restoreGState()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            
            // Clicou no meio, mosra recebe false
            let centro = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
            let distancia = Int(sqrt(pow(currentPoint.x - centro.x, 2) + pow(currentPoint.y - centro.y, 2)))
            
            if ( distancia < raio ) {
                mostraAlerta = false
                setNeedsDisplay()
                return
            }
            
            for i in 0...15 {
                let imagem = images[i]
                
                if (currentPoint.x) < imagem.origin.x + imagem.width
                    && (currentPoint.x) > imagem.origin.x &&
                    (currentPoint.y) < imagem.height + imagem.origin.y
                    && (currentPoint.y) > imagem.origin.y {
                    
                    //print("\(i) - [\(currentPoint.x),\(currentPoint.y)]")
                    mostraAlerta = true
                    indiceSabores = i
                    self.setNeedsDisplay()
                    break
                }
            }
        }
        super.touchesBegan(touches, with: event)
    }

    /**
     Este método devolve a coordenada baseada no centro da tela, no raio e no angulo para onde aponta
     
     ## Important Notes ##
     Os angulos internos tem que ser em radianos, daí a conversão feita internamente no código
     
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter angulo: O angulo para onde ele aponta
     - Returns: CGPoint para desenhar/escrever
     
     */
    func getCoordenadas(centro: CGPoint, raio: Int, angulo: Double) -> CGPoint {
        let x = centro.x + (CGFloat) (cos(angulo*Double.pi/180.0)*Double(raio))
        let y = centro.y - (CGFloat) (sin(angulo*Double.pi/180.0)*Double(raio))
        return CGPoint(x:x, y:y)
    }
    
    /**
     Desenha pequenos círculos nas junções das linhas e circulos grandes
     
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     
     */
    func desenhaCirculosPequenos(context: CGContext, centro: CGPoint, raio: Int) {
        for i in stride(from: 0, to: raio, by: raio/5) {
            for j in stride(from: 0, to: 360, by: 22.5) {
                let p = getCoordenadas(centro: centro, raio: i, angulo: j);
                let rectangle = CGRect(x: p.x-2, y: p.y-2, width: 4, height: 4)
                context.addEllipse(in: rectangle)
            }
        }
    }
    
    /**
     Desenha as linas que dividem a tela para cada sabor
     
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     
     */
    func desenhaLinhas(context: CGContext, centro: CGPoint, raio: Int) {
        for i in stride(from: 0, to: 360, by: 22.5) {
            let p = getCoordenadas(centro: centro, raio: raio, angulo: i)
            context.move(to: centro)
            context.addLine(to: p)
        }
    }
    
    /**
     Desenha a roda e as divisões menores
     
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     
     */
    func desenhaRoda(context: CGContext, centro: CGPoint, raio: Int) {
        let passo = CGFloat(raio/5)
        
        context.addEllipse(in: CGRect(x: centro.x-passo*5, y: centro.y-passo*5, width: passo*10, height: passo*10))
        
        
        //context.addEllipse(in: CGRect(x: centro.x-passo*4, y: centro.y-passo*4, width: passo*8,  height: passo*8))
        //context.addEllipse(in: CGRect(x: centro.x-passo*3, y: centro.y-passo*3, width: passo*6,  height: passo*6))
        //context.addEllipse(in: CGRect(x: centro.x-passo*2, y: centro.y-passo*2, width: passo*4,  height: passo*4))
        //context.addEllipse(in: CGRect(x: centro.x-passo,   y: centro.y-passo,   width: passo*2,  height: passo*2))
    }
    
    /**
     Escreve o texto na tela referente ao sabor
     
     - Parameter texto: O texto a ser impresso
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter angulo: O angulo para onde ele aponta
     
     */
    func escreveTexto(texto: String, centro: CGPoint, raio: Int, angulo: Double){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center;
        
        let font = UIFont(name: "Helvetica-Bold", size:9.0)
        let novoCentro = CGPoint(x: centro.x-20, y: centro.y-5)
        let novoRaio = raio + 25
        let origem = getCoordenadas(centro: novoCentro, raio: novoRaio, angulo: angulo)

        let attributes:[String:Any] = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: paragraphStyle]
        
        let myString: NSString = texto as NSString
        let size = myString.size(attributes: attributes)
        
        let textRect = CGRect(x: origem.x, y: origem.y, width: size.width, height: size.height);
        
        myString.draw(in: textRect, withAttributes: attributes)
    }
    
    /**
     Escreve o texto na tela referente ao sabor
     
     - Parameter imagem: A imagem a ser desenhada
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter angulo: O angulo para onde ele aponta
     - Returns: CGRect para interceptar o clique na UIVIew
     
     */
    func desenhaImagem(_ imagem: UIImage, context: CGContext, centro: CGPoint, raio: Int, angulo: Double) -> CGRect {
        var novoCentro = centro
        novoCentro.y += 20
        let novoRaio = raio + 5
        
            if let cgImage = imagem.cgImage {
                let ponto = getCoordenadas(centro: novoCentro, raio: novoRaio, angulo: angulo)
                
                let rect = CGRect(x: ponto.x - CGFloat(cgImage.width/2), y: ponto.y - CGFloat(cgImage.height), width: CGFloat(cgImage.width), height: CGFloat(cgImage.height))
                
                imagem.draw(in: rect)
                //context.draw(cgImage, in: rect)
                
                return rect
            }
        
        return CGRect.zero
    }

    /**
     Desenha o gráfico preenchido com os sabores do usuário/torrador/média geral
     
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter flavor: Objeto contendo a avaliação
     - Parameter cores: Array de cores a serem usadas no sistema de impressão
     
     */
    func desenhaGraficoPreenchido (context: CGContext, centro: CGPoint, raio: Int, flavor: Flavor, cores: [UIColor]) {
        context.setLineWidth(2.0)
        
        let doce1 = getCoordenadas(centro: centro, raio: Int(flavor.doce)*raio/10,  angulo:0)
        let doce2 = getCoordenadas(centro: centro, raio: Int(flavor.doce)*raio/10,  angulo:22.5)
        context.move(to: centro)
        context.addLine(to: doce1)
        context.addLine(to: doce2)
        context.setFillColor(cores[0].cgColor)
        context.fillPath()
        
        let azedo1 = getCoordenadas(centro: centro, raio:Int(flavor.azedo)*raio/10, angulo:22.5)
        let azedo2 = getCoordenadas(centro: centro, raio:Int(flavor.azedo)*raio/10, angulo:45)
        context.move(to: centro)
        context.addLine(to: azedo1)
        context.addLine(to: azedo2)
        context.setFillColor(cores[1].cgColor)
        context.fillPath()
       
        let floral1 = getCoordenadas(centro: centro, raio:Int(flavor.floral)*raio/10, angulo:45)
        let floral2 = getCoordenadas(centro: centro, raio:Int(flavor.floral)*raio/10, angulo:67.5)
        context.move(to: centro)
        context.addLine(to: floral1)
        context.addLine(to: floral2)
        context.setFillColor(cores[2].cgColor)
        context.fillPath()
        
        let especiarias1 = getCoordenadas(centro: centro, raio:Int(flavor.especiarias)*raio/10, angulo:67.5)
        let especiarias2 = getCoordenadas(centro: centro, raio:Int(flavor.especiarias)*raio/10, angulo:90)
        context.move(to: centro)
        context.addLine(to: especiarias1)
        context.addLine(to: especiarias2)
        context.setFillColor(cores[3].cgColor)
        context.fillPath()
        
        let salgado1 = getCoordenadas(centro: centro, raio:Int(flavor.salgado)*raio/10, angulo:90)
        let salgado2 = getCoordenadas(centro: centro, raio:Int(flavor.salgado)*raio/10, angulo:112.5)
        context.move(to: centro)
        context.addLine(to: salgado1)
        context.addLine(to: salgado2)
        context.setFillColor(cores[4].cgColor)
        context.fillPath()
        
        let frutasVermelhas1 = getCoordenadas(centro: centro, raio:Int(flavor.frutasVermelhas)*raio/10, angulo:112.5)
        let frutasVermelhas2 = getCoordenadas(centro: centro, raio:Int(flavor.frutasVermelhas)*raio/10, angulo:135)
        context.move(to: centro)
        context.addLine(to: frutasVermelhas1)
        context.addLine(to: frutasVermelhas2)
        context.setFillColor(cores[5].cgColor)
        context.fillPath()
        
        let frutasCitrico1 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCitricas)*raio/10, angulo:135)
        let frutasCitrico2 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCitricas)*raio/10, angulo:157.5)
        context.move(to: centro)
        context.addLine(to: frutasCitrico1)
        context.addLine(to: frutasCitrico2)
        context.setFillColor(cores[6].cgColor)
        context.fillPath()
        
        let frutasCaroco1 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCaroco)*raio/10, angulo:157.5)
        let frutasCaroco2 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCaroco)*raio/10, angulo:180)
        context.move(to: centro)
        context.addLine(to: frutasCaroco1)
        context.addLine(to: frutasCaroco2)
        context.setFillColor(cores[7].cgColor)
        context.fillPath()
        
        let chocolate1 = getCoordenadas(centro: centro, raio:Int(flavor.chocolate)*raio/10, angulo:180)
        let chocolate2 = getCoordenadas(centro: centro, raio:Int(flavor.chocolate)*raio/10, angulo:202.5)
        context.move(to: centro)
        context.addLine(to: chocolate1)
        context.addLine(to: chocolate2)
        context.setFillColor(cores[8].cgColor)
        context.fillPath()
        
        let caramelo1 = getCoordenadas(centro: centro, raio:Int(flavor.caramelo)*raio/10, angulo:202.5)
        let caramelo2 = getCoordenadas(centro: centro, raio:Int(flavor.caramelo)*raio/10, angulo:225)
        context.move(to: centro)
        context.addLine(to: caramelo1)
        context.addLine(to: caramelo2)
        context.setFillColor(cores[9].cgColor)
        context.fillPath()
        
        let defumado1 = getCoordenadas(centro: centro, raio:Int(flavor.defumado)*raio/10, angulo:225)
        let defumado2 = getCoordenadas(centro: centro, raio:Int(flavor.defumado)*raio/10, angulo:247.5)
        context.move(to: centro)
        context.addLine(to: defumado1)
        context.addLine(to: defumado2)
        context.setFillColor(cores[10].cgColor)
        context.fillPath()
        
        let amargo1 = getCoordenadas(centro: centro, raio:Int(flavor.amargo)*raio/10, angulo:247.5)
        let amargo2 = getCoordenadas(centro: centro, raio:Int(flavor.amargo)*raio/10, angulo:270)
        context.move(to: centro)
        context.addLine(to: amargo1)
        context.addLine(to: amargo2)
        context.setFillColor(cores[11].cgColor)
        context.fillPath()
        
        let herbal1 = getCoordenadas(centro: centro, raio:Int(flavor.herbal)*raio/10, angulo:270)
        let herbal2 = getCoordenadas(centro: centro, raio:Int(flavor.herbal)*raio/10, angulo:292.5)
        context.move(to: centro)
        context.addLine(to: herbal1)
        context.addLine(to: herbal2)
        context.setFillColor(cores[12].cgColor)
        context.fillPath()
        
        let encorpado1 = getCoordenadas(centro: centro, raio:Int(flavor.encorpado)*raio/10, angulo:292.5)
        let encorpado2 = getCoordenadas(centro: centro, raio:Int(flavor.encorpado)*raio/10, angulo:315)
        context.move(to: centro)
        context.addLine(to: encorpado1)
        context.addLine(to: encorpado2)
        context.setFillColor(cores[13].cgColor)
        context.fillPath()
        
        let cereais1 = getCoordenadas(centro: centro, raio:Int(flavor.cereais)*raio/10, angulo:315)
        let cereais2 = getCoordenadas(centro: centro, raio:Int(flavor.cereais)*raio/10, angulo:337)
        context.move(to: centro)
        context.addLine(to: cereais1)
        context.addLine(to: cereais2)
        context.setFillColor(cores[14].cgColor)
        context.fillPath()
        
        let nozes1 = getCoordenadas(centro: centro, raio:Int(flavor.nozes)*raio/10, angulo:337)
        let nozes2 = getCoordenadas(centro: centro, raio:Int(flavor.nozes)*raio/10, angulo:360)
        context.move(to: centro)
        context.addLine(to: nozes1)
        context.addLine(to: nozes2)
        context.setFillColor(cores[15].cgColor)
        context.fillPath()
    }
    
    /**
     Desenha o gráfico sem preenchimento com os sabores do usuário/torrador/média geral
     
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter flavor: Objeto contendo a avaliação
     - Parameter cor: A cor de impressão da avaliação da roda
     
     */
    func desenhaGrafico (context: CGContext, centro: CGPoint, raio: Int, flavor: Flavor, cor: UIColor) {
        context.setLineWidth(2.0)
        context.setStrokeColor(cor.cgColor)
        context.setFillColor(UIColor.blue.cgColor)
        
        let doce = getCoordenadas(centro: centro, raio:Int(flavor.doce)*raio/10, angulo:11.25)
        let azedo = getCoordenadas(centro: centro, raio:Int(flavor.azedo)*raio/10, angulo:33.75)
        let floral = getCoordenadas(centro: centro, raio:Int(flavor.floral)*raio/10, angulo:56.25)
        let especiarias = getCoordenadas(centro: centro, raio:Int(flavor.especiarias)*raio/10, angulo:78.75)
        let salgado = getCoordenadas(centro: centro, raio: Int(flavor.salgado)*raio/10,  angulo:101.25)
        let frutasVermelhas = getCoordenadas(centro: centro, raio:Int(flavor.frutasVermelhas)*raio/10, angulo:123.75)
        let frutasCitricas = getCoordenadas(centro: centro, raio:Int(flavor.frutasCitricas)*raio/10, angulo:146.25)
        let frutasCaroco = getCoordenadas(centro: centro, raio:Int(flavor.frutasCaroco)*raio/10, angulo:168.75)
        let chocolate = getCoordenadas(centro: centro, raio:Int(flavor.chocolate)*raio/10, angulo:191.25)
        let caramelo = getCoordenadas(centro: centro, raio:Int(flavor.caramelo)*raio/10, angulo:213.75)
        let defumado = getCoordenadas(centro: centro, raio:Int(flavor.defumado)*raio/10, angulo:236.25)
        let amargo = getCoordenadas(centro: centro, raio:Int(flavor.amargo)*raio/10, angulo:258.75)
        let herbal = getCoordenadas(centro: centro, raio:Int(flavor.herbal)*raio/10, angulo:281.25)
        let encorpado = getCoordenadas(centro: centro, raio:Int(flavor.encorpado)*raio/10, angulo:303.75)
        let cereais = getCoordenadas(centro: centro, raio:Int(flavor.cereais)*raio/10, angulo:326.25)
        let nozes = getCoordenadas(centro: centro, raio:Int(flavor.nozes)*raio/10, angulo:348.75)
        
        context.move(to: doce)
        context.addLine(to: azedo)
        context.addLine(to: floral)
        context.addLine(to: especiarias)
        context.addLine(to: salgado)
        context.addLine(to: frutasVermelhas)
        context.addLine(to: frutasCitricas)
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
    
    /**
     Transforma a cor hexadecimal em UIColor
     
     - Parameter hex: Recebe a cor em hexadecimal
     - Returns: UIColor cor segundo o ios
     
     */
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.8)
        )
    }

}

