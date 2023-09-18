//
//  ChapterTransitionBackgroundBox.swift
//  witchie
//
//  Created by egln on 15/09/23.
//

import SwiftUI

struct StarPath: View{
    
    @StateObject var dimensionManager = DimensionManager.shared

    let color: Color
    let color2 = Color(ColorAsset.LIGHT_BEGE)
    let pathBounds = UIBezierPath.calculateBounds(paths: [.star])
    var body: some View{
        Spacer()
        VStack (alignment: .center){
            Spacer()
            Group{
                ScaledBezier(bezier: .star, pathBounds: pathBounds)
                    .foregroundColor(color2)
                    .scaledToFit()
                   // .frame(width: dimensionManager.dimensions.width, height: dimensionManager.dimensions.width * 0.8)                    .border(.red)
                    .overlay(ScaledBezier(bezier: .star, pathBounds: pathBounds)
                        .stroke(color, lineWidth: 8)
                        .scaledToFit())
            }
        }.frame(width: dimensionManager.dimensions.width, height: dimensionManager.dimensions.width * 0.8)
            .border(.green)
    }
}

struct ScaledBezier: Shape {
    @StateObject var dimensionManager = DimensionManager.shared
    let bezier: UIBezierPath
    let pathBounds: CGRect

    func path(in rect: CGRect) -> Path {
        let pointScale = (rect.width >= rect.height) ? max(pathBounds.height, pathBounds.width) : min(pathBounds.height, pathBounds.width)
        let pointTransform = CGAffineTransform(scaleX: 1/pointScale, y: 1/pointScale)
        let path = Path(bezier.cgPath).applying(pointTransform)
       let multiplier = min(rect.width, rect.height)
       let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)

       return path.applying(transform)
    }
}

extension UIBezierPath {
    static func calculateBounds(paths: [UIBezierPath]) -> CGRect {
        let myPaths = UIBezierPath()
        for path in paths {
            myPaths.append(path)
        }
        return (myPaths.bounds)
    }
    static var cordinatorsMultiplier: CGFloat = 1

    /// The Unwrap logo as a Bezier path.
    static var star: UIBezierPath {
        let path = UIBezierPath()
        let zero = CGPoint(x: 32.3, y: 3)
        
        path.move(to: zero)
        let point1 = CGPoint(x: zero.x + 117.5 * cordinatorsMultiplier, y: zero.y)
        
        path.addLine(to: point1)
        path.addCurve(to: CGPoint(x: point1.x + 8.3, y: 11.3), controlPoint1: CGPoint(x: point1.x + 4.5, y: 3), controlPoint2: CGPoint(x: point1.x + 8.3, y: 6.7))
    
        
        path.addLine(to: CGPoint(x: point1.x + 8.3, y: 16.2))
        path.addCurve(to: CGPoint(x: point1.x + 16.6, y: 24.5), controlPoint1: CGPoint(x: point1.x + 8.3, y: 20.8), controlPoint2: CGPoint(x: point1.x + 12.0, y: 24.5))
        
        
        path.addLine(to: CGPoint(x: point1.x + 21.9, y: 24.5))
        path.addCurve(to: CGPoint(x: point1.x + 30.2, y: 32.8), controlPoint1: CGPoint(x: point1.x + 26.5, y: 24.5), controlPoint2: CGPoint(x: point1.x + 30.2 , y: 28.2))
        
        
        path.addLine(to: CGPoint(x: point1.x + 30.2, y: 141))
        path.addCurve(to: CGPoint(x: point1.x + 21.9, y: 149.2), controlPoint1: CGPoint(x: point1.x + 30.2, y: 145.5), controlPoint2: CGPoint(x: point1.x + 26.5, y: 149.2))
        
        
        path.addLine(to: CGPoint(x: point1.x + 16.6, y: 149.2))
        path.addCurve(to: CGPoint(x: point1.x + 8.3, y: 157.5), controlPoint1: CGPoint(x: point1.x + 12, y: 149.2), controlPoint2: CGPoint(x: point1.x + 8.3, y: 153))
        
        
        path.addLine(to: CGPoint(x: point1.x + 8.3, y: 161.4))
        path.addCurve(to: CGPoint(x: point1.x, y: 169.7), controlPoint1: CGPoint(x: point1.x + 8.3, y: 166), controlPoint2: CGPoint(x: point1.x + 4.5, y: 169.7))
        
        path.addLine(to: CGPoint(x: 10.9, y: 169.7))
        path.addCurve(to: CGPoint(x: 2.6, y: 161.4), controlPoint1: CGPoint(x: 6.4, y: 169.7), controlPoint2: CGPoint(x: 2.6, y: 166))
        
        
        path.addLine(to: CGPoint(x: 2.6, y: 32.8))
        path.addCurve(to: CGPoint(x: 10.9, y: 24.5), controlPoint1: CGPoint(x: 2.6, y: 28.2), controlPoint2: CGPoint(x: 6.4, y: 24.5))
        
        
        path.addLine(to: CGPoint(x: 15.8, y: 24.5))
        path.addCurve(to: CGPoint(x: 24, y: 16.2), controlPoint1: CGPoint(x: 20.3, y: 24.5), controlPoint2: CGPoint(x: 24, y: 20.8))
        
        
        path.addLine(to: CGPoint(x: 24, y: 11.3))
        path.addCurve(to: CGPoint(x: 32.3, y: 3), controlPoint1: CGPoint(x: 24, y: 6.7), controlPoint2: CGPoint(x: 27.8 , y: 3))
       
        path.close()
        return path
    }
}

struct StarPath_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
