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
    
    /// **flavorTorrador** é a variavel que conterá a roda de sabores que o torrador fez para o café
    var flavorTorrador:Flavor?
    /// **flavorMédia** é a variavel que conterá a roda de sabores que a média geral avaliou
    var flavorMedia:Flavor?
    /// **flavorUsuario** é a variavel que conterá a roda de sabores que o usuário preencheu
    var flavorUsuario:Flavor?
    
    var images:[CGRect] = []
    
    override func draw(_ rect: CGRect) {
        let centro = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        var raio:Int = Int(centro.y/2)
        if ( centro.x > centro.y ) {
            raio = Int(centro.x/2)
        }
    
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(CGFloat(0.5))
            context.setStrokeColor(UIColor.black.cgColor)
            
            desenhaLinhas(context: context, centro:centro, raio:raio)
            
//            escreveTexto(texto: "Salgado", centro:centro, raio:raio, angulo:0)
//            escreveTexto(texto: "Especiarias", centro:centro, raio:raio, angulo:22.5)
//            escreveTexto(texto: "Floral", centro:centro, raio:raio, angulo:45)
//            escreveTexto(texto: "Azedo", centro:centro, raio:raio, angulo:67.5)
//            escreveTexto(texto: "Doce", centro:centro, raio:raio, angulo:90)
//            escreveTexto(texto: "Nozes", centro:centro, raio:raio, angulo:112.5)
//            escreveTexto(texto: "Cereais", centro:centro, raio:raio, angulo:135)
//            escreveTexto(texto: "Encorpado", centro:centro, raio:raio, angulo:157.5)
//            escreveTexto(texto: "Herbal", centro:centro, raio:raio, angulo:180)
//            escreveTexto(texto: "Amargo", centro:centro, raio:raio, angulo:202.5)
//            escreveTexto(texto: "Defumado", centro:centro, raio:raio, angulo:225)
//            escreveTexto(texto: "Caramelo", centro:centro, raio:raio, angulo:247.5)
//            escreveTexto(texto: "Chocolate", centro:centro, raio:raio, angulo:270)
//            escreveTexto(texto: "Frutas com Caroço", centro:centro, raio:raio, angulo:292.5)
//            escreveTexto(texto: "Frutas Cítricas", centro:centro, raio:raio, angulo:315)
//            escreveTexto(texto: "Frutas Vermelhas", centro:centro, raio:raio, angulo:337.5)
            
            images = [
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:11.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:33.75),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:56.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:78.75),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:101.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:123.75),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:146.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:168.75),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:191.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:213.75),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:236.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:258.75),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:281.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:303.75),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:326.25),
                desenhaImagem(imagem: "cereais.png", context: context, centro:centro, raio:(raio+20), angulo:348.75)
            ]
            
            desenhaRoda(context: context, centro:centro, raio:raio)
            desenhaCirculosPequenos(context: context, centro:centro, raio:raio)
            context.strokePath()
            
            let cores = [self.hexStringToUIColor(hex: "5E3A17"),
                         self.hexStringToUIColor(hex: "BE8E3D"),
                         self.hexStringToUIColor(hex: "9C8A33"),
                         self.hexStringToUIColor(hex: "C5B742"),
                         self.hexStringToUIColor(hex: "BC6337"),
                         self.hexStringToUIColor(hex: "D7925B"),
                         self.hexStringToUIColor(hex: "ECC56E"),
                         self.hexStringToUIColor(hex: "E7CB9B"),
                         self.hexStringToUIColor(hex: "3287A5"),
                         self.hexStringToUIColor(hex: "8DB7A5"),
                         self.hexStringToUIColor(hex: "703B52"),
                         self.hexStringToUIColor(hex: "945A72"),
                         self.hexStringToUIColor(hex: "422718"),
                         self.hexStringToUIColor(hex: "9C8A33"),
                         self.hexStringToUIColor(hex: "C5B742"),
                         self.hexStringToUIColor(hex: "BC6337")]
            
            if let flavor = flavorUsuario {
                desenhaGraficoPreenchido(context: context, centro:centro, raio:raio, flavor:flavor, cores: cores)
            }
            if let flavor = flavorTorrador {
                desenhaGrafico(context: context, centro:centro, raio:raio, flavor:flavor, cor: UIColor.red)
            }
            if let flavor = flavorMedia {
                desenhaGrafico(context: context, centro:centro, raio:raio, flavor:flavor, cor: UIColor.blue)
            }
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            
            for i in 0...15 {
                let imagem = images[i]
                
                if (currentPoint.x) < imagem.origin.x + imagem.width
                    && (currentPoint.x) > imagem.origin.x &&
                    (currentPoint.y) < imagem.height + imagem.origin.y
                    && (currentPoint.y) > imagem.origin.y {
                    
                    print("\(i) - [\(currentPoint.x),\(currentPoint.y)]")
//                    mostraAlertaDaPosicao(i)
                    break
                }
            }
        }
    }

    /**
     Este método devolve a coordenada baseada no centro da tela, no raio e no angulo para onde aponta
     
     ## Important Notes ##
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter angulo: O angulo para onde ele aponta
     - Returns: CGPoint para desenhar/escrever
     
     */
    func getCoordenadas(centro: CGPoint, raio: Int, angulo: Double) -> CGPoint {
        let x = centro.x + (CGFloat) (cos(angulo*M_PI/180.0)*Double(raio))
        let y = centro.y - (CGFloat) (sin(angulo*M_PI/180.0)*Double(raio))
        return CGPoint(x:x, y:y)
    }
    
    /**
     Desenha pequenos círculos nas junções das linhas e circulos grandes
     
     ## Important Notes ##
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
     
     ## Important Notes ##
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
     
     ## Important Notes ##
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     
     */
    func desenhaRoda(context: CGContext, centro: CGPoint, raio: Int) {
        let passo = CGFloat(raio/5)
        
        context.addEllipse(in: CGRect(x: centro.x-passo*5, y: centro.y-passo*5, width: passo*10, height: passo*10))
        context.addEllipse(in: CGRect(x: centro.x-passo*4, y: centro.y-passo*4, width: passo*8,  height: passo*8))
        context.addEllipse(in: CGRect(x: centro.x-passo*3, y: centro.y-passo*3, width: passo*6,  height: passo*6))
        context.addEllipse(in: CGRect(x: centro.x-passo*2, y: centro.y-passo*2, width: passo*4,  height: passo*4))
        context.addEllipse(in: CGRect(x: centro.x-passo,   y: centro.y-passo,   width: passo*2,  height: passo*2))
    }
    
    /**
     Escreve o texto na tela referente ao sabor
     
     ## Important Notes ##
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

        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: paragraphStyle]
        
        let myString: NSString = texto as NSString
        let size: CGSize = myString.size(attributes: attributes)
        
        let textRect = CGRect(x: origem.x, y: origem.y, width: size.width, height: size.height);
        
        myString.draw(in: textRect, withAttributes: attributes)
    }
    
    /**
     Escreve o texto na tela referente ao sabor
     
     ## Important Notes ##
     - Parameter imagem: A imagem a ser desenhada
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter angulo: O angulo para onde ele aponta
     - Returns: CGRect para interceptar o clique na UIVIew
     
     */
    func desenhaImagem(imagem: String, context: CGContext, centro: CGPoint, raio: Int, angulo: Double) -> CGRect {
        var novoCentro = centro
        novoCentro.y += 20
        if let imageUI = UIImage(named:imagem) {
            if let image = imageUI.cgImage {
                let ponto = getCoordenadas(centro: novoCentro, raio: raio, angulo: angulo)
                
                let rect = CGRect(x: ponto.x - CGFloat(image.width/2), y: ponto.y - CGFloat(image.height), width: CGFloat(image.width), height: CGFloat(image.height))
                
                context.draw(image, in: rect)
                return rect
            }
        }
        return CGRect.zero
    }

    /**
     Desenha o gráfico preenchido com os sabores do usuário/torrador/média geral
     
     ## Important Notes ##
     - Parameter context: Recebe o canvas para desenhar
     - Parameter centro: O centro da tela para iniciar o calculo
     - Parameter raio: A distancia do centro para se desenhar
     - Parameter flavor: Objeto contendo a avaliação
     - Parameter cores: Array de cores a serem usadas no sistema de impressão
     
     */
    func desenhaGraficoPreenchido (context: CGContext, centro: CGPoint, raio: Int, flavor: Flavor, cores: [UIColor]) {
        context.setLineWidth(2.0)
        
        let doce1 = getCoordenadas(centro: centro, raio: Int(flavor.doce)*raio/10,  angulo:90)
        let doce2 = getCoordenadas(centro: centro, raio: Int(flavor.doce)*raio/10,  angulo:67.5)
        context.move(to: centro)
        context.addLine(to: doce1)
        context.addLine(to: doce2)
        context.setFillColor(cores[0].cgColor)
        context.fillPath()
        
        let azedo1 = getCoordenadas(centro: centro, raio:Int(flavor.azedo)*raio/10, angulo:67.5)
        let azedo2 = getCoordenadas(centro: centro, raio:Int(flavor.azedo)*raio/10, angulo:45)
        context.move(to: centro)
        context.addLine(to: azedo1)
        context.addLine(to: azedo2)
        context.setFillColor(cores[1].cgColor)
        context.fillPath()
       
        let floral1 = getCoordenadas(centro: centro, raio:Int(flavor.floral)*raio/10, angulo:45)
        let floral2 = getCoordenadas(centro: centro, raio:Int(flavor.floral)*raio/10, angulo:22.5)
        context.move(to: centro)
        context.addLine(to: floral1)
        context.addLine(to: floral2)
        context.setFillColor(cores[2].cgColor)
        context.fillPath()
        
        let especiarias1 = getCoordenadas(centro: centro, raio:Int(flavor.especiarias)*raio/10, angulo:22.5)
        let especiarias2 = getCoordenadas(centro: centro, raio:Int(flavor.especiarias)*raio/10, angulo:0)
        context.move(to: centro)
        context.addLine(to: especiarias1)
        context.addLine(to: especiarias2)
        context.setFillColor(cores[3].cgColor)
        context.fillPath()
        
        let salgado1 = getCoordenadas(centro: centro, raio:Int(flavor.salgado)*raio/10, angulo:0)
        let salgado2 = getCoordenadas(centro: centro, raio:Int(flavor.salgado)*raio/10, angulo:337.5)
        context.move(to: centro)
        context.addLine(to: salgado1)
        context.addLine(to: salgado2)
        context.setFillColor(cores[4].cgColor)
        context.fillPath()
        
        let frutasVermelhas1 = getCoordenadas(centro: centro, raio:Int(flavor.frutasVermelhas)*raio/10, angulo:337.5)
        let frutasVermelhas2 = getCoordenadas(centro: centro, raio:Int(flavor.frutasVermelhas)*raio/10, angulo:315)
        context.move(to: centro)
        context.addLine(to: frutasVermelhas1)
        context.addLine(to: frutasVermelhas2)
        context.setFillColor(cores[5].cgColor)
        context.fillPath()
        
        let frutasCitrico1 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCitricas)*raio/10, angulo:315)
        let frutasCitrico2 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCitricas)*raio/10, angulo:292.5)
        context.move(to: centro)
        context.addLine(to: frutasCitrico1)
        context.addLine(to: frutasCitrico2)
        context.setFillColor(cores[6].cgColor)
        context.fillPath()
        
        let frutasCaroco1 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCaroco)*raio/10, angulo:292.5)
        let frutasCaroco2 = getCoordenadas(centro: centro, raio:Int(flavor.frutasCaroco)*raio/10, angulo:270)
        context.move(to: centro)
        context.addLine(to: frutasCaroco1)
        context.addLine(to: frutasCaroco2)
        context.setFillColor(cores[7].cgColor)
        context.fillPath()
        
        let chocolate1 = getCoordenadas(centro: centro, raio:Int(flavor.chocolate)*raio/10, angulo:270)
        let chocolate2 = getCoordenadas(centro: centro, raio:Int(flavor.chocolate)*raio/10, angulo:247.5)
        context.move(to: centro)
        context.addLine(to: chocolate1)
        context.addLine(to: chocolate2)
        context.setFillColor(cores[8].cgColor)
        context.fillPath()
        
        let caramelo1 = getCoordenadas(centro: centro, raio:Int(flavor.caramelo)*raio/10, angulo:247.5)
        let caramelo2 = getCoordenadas(centro: centro, raio:Int(flavor.caramelo)*raio/10, angulo:225)
        context.move(to: centro)
        context.addLine(to: caramelo1)
        context.addLine(to: caramelo2)
        context.setFillColor(cores[9].cgColor)
        context.fillPath()
        
        let defumado1 = getCoordenadas(centro: centro, raio:Int(flavor.defumado)*raio/10, angulo:225)
        let defumado2 = getCoordenadas(centro: centro, raio:Int(flavor.defumado)*raio/10, angulo:202.5)
        context.move(to: centro)
        context.addLine(to: defumado1)
        context.addLine(to: defumado2)
        context.setFillColor(cores[10].cgColor)
        context.fillPath()
        
        let amargo1 = getCoordenadas(centro: centro, raio:Int(flavor.amargo)*raio/10, angulo:202.5)
        let amargo2 = getCoordenadas(centro: centro, raio:Int(flavor.amargo)*raio/10, angulo:180)
        context.move(to: centro)
        context.addLine(to: amargo1)
        context.addLine(to: amargo2)
        context.setFillColor(cores[11].cgColor)
        context.fillPath()
        
        let herbal1 = getCoordenadas(centro: centro, raio:Int(flavor.herbal)*raio/10, angulo:180)
        let herbal2 = getCoordenadas(centro: centro, raio:Int(flavor.herbal)*raio/10, angulo:157.5)
        context.move(to: centro)
        context.addLine(to: herbal1)
        context.addLine(to: herbal2)
        context.setFillColor(cores[12].cgColor)
        context.fillPath()
        
        let encorpado1 = getCoordenadas(centro: centro, raio:Int(flavor.encorpado)*raio/10, angulo:157.5)
        let encorpado2 = getCoordenadas(centro: centro, raio:Int(flavor.encorpado)*raio/10, angulo:135)
        context.move(to: centro)
        context.addLine(to: encorpado1)
        context.addLine(to: encorpado2)
        context.setFillColor(cores[13].cgColor)
        context.fillPath()
        
        let cereais1 = getCoordenadas(centro: centro, raio:Int(flavor.cereais)*raio/10, angulo:135)
        let cereais2 = getCoordenadas(centro: centro, raio:Int(flavor.cereais)*raio/10, angulo:112.5)
        context.move(to: centro)
        context.addLine(to: cereais1)
        context.addLine(to: cereais2)
        context.setFillColor(cores[14].cgColor)
        context.fillPath()
        
        let nozes1 = getCoordenadas(centro: centro, raio:Int(flavor.nozes)*raio/10, angulo:112.5)
        let nozes2 = getCoordenadas(centro: centro, raio:Int(flavor.nozes)*raio/10, angulo:90)
        context.move(to: centro)
        context.addLine(to: nozes1)
        context.addLine(to: nozes2)
        context.setFillColor(cores[15].cgColor)
        context.fillPath()
    }
    
    /**
     Desenha o gráfico sem preenchimento com os sabores do usuário/torrador/média geral
     
     ## Important Notes ##
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
        let doce = getCoordenadas(centro: centro, raio: Int(flavor.doce)*raio/10,  angulo:90)
        let azedo = getCoordenadas(centro: centro, raio:Int(flavor.azedo)*raio/10, angulo:67.5)
        let floral = getCoordenadas(centro: centro, raio:Int(flavor.floral)*raio/10, angulo:45)
        let especiarias = getCoordenadas(centro: centro, raio:Int(flavor.especiarias)*raio/10, angulo:22.5)
        let salgado = getCoordenadas(centro: centro, raio:Int(flavor.salgado)*raio/10, angulo:0)
        let frutasVermelhas = getCoordenadas(centro: centro, raio:Int(flavor.frutasVermelhas)*raio/10, angulo:337.5)
        let frutasCitrico = getCoordenadas(centro: centro, raio:Int(flavor.frutasCitricas)*raio/10, angulo:315)
        let frutasCaroco = getCoordenadas(centro: centro, raio:Int(flavor.frutasCaroco)*raio/10, angulo:292.5)
        let chocolate = getCoordenadas(centro: centro, raio:Int(flavor.chocolate)*raio/10, angulo:270)
        let caramelo = getCoordenadas(centro: centro, raio:Int(flavor.caramelo)*raio/10, angulo:247.5)
        let defumado = getCoordenadas(centro: centro, raio:Int(flavor.defumado)*raio/10, angulo:225)
        let amargo = getCoordenadas(centro: centro, raio:Int(flavor.amargo)*raio/10, angulo:202.5)
        let herbal = getCoordenadas(centro: centro, raio:Int(flavor.herbal)*raio/10, angulo:180)
        let encorpado = getCoordenadas(centro: centro, raio:Int(flavor.encorpado)*raio/10, angulo:157.5)
        let cereais = getCoordenadas(centro: centro, raio:Int(flavor.cereais)*raio/10, angulo:135)
        let nozes = getCoordenadas(centro: centro, raio:Int(flavor.nozes)*raio/10, angulo:112.5)
        
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
    
    /**
     Transforma a cor hexadecimal em UIColor
     
     ## Important Notes ##
     - Parameter hex: Recebe a cor em hexadecimal
     - Returns: UIColor cor segundo o ios
     
     */
    func hexStringToUIColor (hex:String) -> UIColor {
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

