//
//  StarPath.swift
//  witchie
//
//  Created by ditthales on 12/09/23.
//

import SwiftUI

struct StarPath: View{
    
    let color: Color
    
    let pathBounds = UIBezierPath.calculateBounds(paths: [.star])
    
    var body: some View{
        ScaledBezier(bezier: .star, pathBounds: pathBounds).foregroundColor(color)
    }
}

struct ScaledBezier: Shape {
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
    /// The Unwrap logo as a Bezier path.
    static var star: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16.5, y: 0.8))
        path.addCurve(to: CGPoint(x: 18.5, y: 0.8), controlPoint1: CGPoint(x: 16.7, y: -0.3), controlPoint2: CGPoint(x: 18.3, y: -0.3))
        path.addLine(to: CGPoint(x: 20, y: 8.1))
        path.addCurve(to: CGPoint(x: 21.6, y: 8.7), controlPoint1: CGPoint(x: 20.1, y: 8.9), controlPoint2: CGPoint(x: 21, y: 9.2))
        path.addLine(to: CGPoint(x: 27.4, y: 4.1))
        path.addCurve(to: CGPoint(x: 28.9, y: 5.3), controlPoint1: CGPoint(x: 28.3, y: 3.4), controlPoint2: CGPoint(x: 29.5, y: 4.4))
        path.addLine(to: CGPoint(x: 25.4, y: 11.9))
        path.addCurve(to: CGPoint(x: 26.2, y: 13.4), controlPoint1: CGPoint(x: 25, y: 12.6), controlPoint2: CGPoint(x: 25.5, y: 13.4))
        path.addLine(to: CGPoint(x: 33.7, y: 13.6))
        path.addCurve(to: CGPoint(x: 34.1, y: 15.5), controlPoint1: CGPoint(x: 34.8, y: 13.6), controlPoint2: CGPoint(x: 35.1, y: 15.1))
        path.addLine(to: CGPoint(x: 27.1, y: 18.3))
        path.addCurve(to: CGPoint(x: 26.8, y: 19.9), controlPoint1: CGPoint(x: 26.4, y: 18.5), controlPoint2: CGPoint(x: 26.2, y: 19.5))
        path.addLine(to: CGPoint(x: 32.4, y: 24.9))
        path.addCurve(to: CGPoint(x: 31.4, y: 26.6), controlPoint1: CGPoint(x: 33.2, y: 25.6), controlPoint2: CGPoint(x: 32.4, y: 27))
        path.addLine(to: CGPoint(x: 24.3, y: 24.2))
        path.addCurve(to: CGPoint(x: 23, y: 25.3), controlPoint1: CGPoint(x: 23.6, y: 24), controlPoint2: CGPoint(x: 22.9, y: 24.6))
        path.addLine(to: CGPoint(x: 24.1, y: 32.7))
        path.addCurve(to: CGPoint(x: 22.3, y: 33.4), controlPoint1: CGPoint(x: 24.3, y: 33.8), controlPoint2: CGPoint(x: 22.8, y: 34.3))
        path.addLine(to: CGPoint(x: 18.4, y: 27))
        path.addCurve(to: CGPoint(x: 16.6, y: 27), controlPoint1: CGPoint(x: 18, y: 26.4), controlPoint2: CGPoint(x: 17, y: 26.4))
        path.addLine(to: CGPoint(x: 12.7, y: 33.4))
        path.addCurve(to: CGPoint(x: 10.9, y: 32.7), controlPoint1: CGPoint(x: 12.2, y: 34.3), controlPoint2: CGPoint(x: 10.7, y: 33.8))
        path.addLine(to: CGPoint(x: 12, y: 25.3))
        path.addCurve(to: CGPoint(x: 10.7, y: 24.2), controlPoint1: CGPoint(x: 12.1, y: 24.6), controlPoint2: CGPoint(x: 11.4, y: 24))
        path.addLine(to: CGPoint(x: 3.6, y: 26.6))
        path.addCurve(to: CGPoint(x: 2.6, y: 24.9), controlPoint1: CGPoint(x: 2.6, y: 27), controlPoint2: CGPoint(x: 1.8, y: 25.6))
        path.addLine(to: CGPoint(x: 8.2, y: 19.9))
        path.addCurve(to: CGPoint(x: 7.9, y: 18.3), controlPoint1: CGPoint(x: 8.8, y: 19.5), controlPoint2: CGPoint(x: 8.6, y: 18.5))
        path.addLine(to: CGPoint(x: 0.9, y: 15.5))
        path.addCurve(to: CGPoint(x: 1.3, y: 13.6), controlPoint1: CGPoint(x: -0.1, y: 15.1), controlPoint2: CGPoint(x: 0.2, y: 13.6))
        path.addLine(to: CGPoint(x: 8.8, y: 13.4))
        path.addCurve(to: CGPoint(x: 9.6, y: 11.9), controlPoint1: CGPoint(x: 9.5, y: 13.4), controlPoint2: CGPoint(x: 10, y: 12.6))
        path.addLine(to: CGPoint(x: 6.1, y: 5.3))
        path.addCurve(to: CGPoint(x: 7.6, y: 4.1), controlPoint1: CGPoint(x: 5.5, y: 4.4), controlPoint2: CGPoint(x: 6.7, y: 3.4))
        path.addLine(to: CGPoint(x: 13.4, y: 8.7))
        path.addCurve(to: CGPoint(x: 15, y: 8.1), controlPoint1: CGPoint(x: 14, y: 9.2), controlPoint2: CGPoint(x: 14.9, y: 8.9))
        path.addLine(to: CGPoint(x: 16.5, y: 0.8))
        path.close()
        return path
    }
}

struct StarPath_Previews: PreviewProvider {
    static var previews: some View {
        StarPath(color: .yellow)
    }
}
