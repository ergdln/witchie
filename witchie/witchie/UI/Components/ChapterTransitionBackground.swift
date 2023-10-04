////
////  SwiftUIView.swift
////  Witchie
////
////  Created by egln on 04/10/23.
////
//
//import SwiftUI
//
//
//struct TextBox: View{
//    
//    public let textBoxStrokeColor: String
//    public let textBoxBackgroundColor:  String
//    public let textBoxWidth: CGFloat
//    public let textBoxHeight: CGFloat
//    
//    var body: some View{
//        VStack(spacing: 0){
//            //TopLine
//            HStack(alignment: .top, spacing: 0){
//                TextBoxCorner(width: 60, height: 60, textBoxCornerColor: textBoxStrokeColor, textBoxCornerBackgroundColor: textBoxBackgroundColor)
//                VStack(spacing: 0){
//                    Rectangle()
//                        .fill(Color(textBoxStrokeColor))
//                        .frame(width: textBoxWidth - 200, height: 10)
//                    
//                    Rectangle()
//                        .fill(Color(textBoxBackgroundColor))
//                }
//                TextBoxCorner(width: 60, height: 60, textBoxCornerColor: textBoxStrokeColor, textBoxCornerBackgroundColor: textBoxBackgroundColor)
//                    .scaleEffect(x: -1, y: 1)
//            }.frame(width: textBoxWidth, height: 80)
//            
//            //Inside
//            HStack(spacing: 0){
//                Rectangle()
//                    .fill(Color(textBoxStrokeColor))
//                    .frame(width: 10, height: textBoxHeight - 160)
//                    .padding(.leading, 60/3)
//                
//                Rectangle()
//                    .fill(Color(textBoxBackgroundColor))
//                
//                Rectangle()
//                    .fill(Color(textBoxStrokeColor))
//                    .frame(width: 10, height: textBoxHeight - 160)
//                    .padding(.trailing, 60/3)
//            }.frame(width: textBoxWidth, height: textBoxHeight - 160)
//            
//            //BottomLine
//            HStack(alignment: .bottom, spacing: -1){
//                TextBoxCorner(width: 60, height: 60, textBoxCornerColor: textBoxStrokeColor, textBoxCornerBackgroundColor: textBoxBackgroundColor)
//                    .scaleEffect(x: 1, y: -1)
//                
//                VStack(spacing: 0){
//                    Rectangle()
//                        .fill(Color(textBoxBackgroundColor))
//                    
//                    Rectangle()
//                        .fill(Color(textBoxStrokeColor))
//                        .frame(height: 10)
//                }
//                
//                VStack(alignment: .trailing, spacing: 0){
//                    
//                    HStack(spacing: 0){
//                        Spacer()
//                            .frame(width: 20, height: 50)
//                            .background(Color(textBoxBackgroundColor))
//                        
//                        Rectangle()
//                            .fill(Color(textBoxStrokeColor))
//                            .frame(width: 10, height: 50)
//                    }
//                    
//                    InsideCorner(width: 60, height: 60, scaledEffectX: 1, scaledEffectY: 1, singleCornerColor: textBoxStrokeColor, singleCornerBackgroundColor: textBoxBackgroundColor)
//                    
//                }.padding(.trailing, 60/3)
//            }.frame(width: textBoxWidth, height: 80)
//        }.frame(width: textBoxWidth)
//    }
//}
//
//
//struct TextBoxCorner: View{
//    public let width: CGFloat
//    public let height: CGFloat
//    public let textBoxCornerColor: String
//    public let textBoxCornerBackgroundColor: String
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 0){
//            VStack{
//                Spacer()
//                    .frame(width: width * 5/6, height: height * 5/6)
//                
//                HStack(spacing:0){
//                    Spacer()
//                        .frame(width: width / 3, height: height * 0.5)
//                    
//                    InsideCorner(width: width, height: height, scaledEffectX: -1, scaledEffectY: -1, singleCornerColor: textBoxCornerColor, singleCornerBackgroundColor: textBoxCornerBackgroundColor)
//                }
//            }
//            
//            VStack(spacing:0){
//                HStack(spacing:0){
//                    
//                    Spacer()
//                        .frame(width: width / 3, height: height * 0.5)
//                    
//                    InsideCorner(width: width, height: height, scaledEffectX: -1, scaledEffectY: -1, singleCornerColor: textBoxCornerColor, singleCornerBackgroundColor: textBoxCornerBackgroundColor)
//                }
//                
//                HStack(spacing: 0){
//                    OutsideCorner(width: width, height: height, scaledEffectX: 1, scaledEffectY: 1, singleCornerColor: textBoxCornerColor, singleCornerBackgroundColor: textBoxCornerBackgroundColor)
//                    
//                    Spacer()
//                        .frame(width: width / 3, height: height * 0.5)
//                        .background(Color(textBoxCornerBackgroundColor))
//                }
//                
//                Spacer()
//                    .frame(width: width * 5/6, height: height / 3)
//                    .background(Color(textBoxCornerBackgroundColor))
//            }
//        }
//    }
//    
//}
//
//struct InsideCorner: View{
//    public let width: CGFloat
//    public let height: CGFloat
//    public let scaledEffectX: CGFloat
//    public let scaledEffectY: CGFloat
//    public let singleCornerColor: String
//    public let singleCornerBackgroundColor: String
//    
//    var body: some View{
//        
//        RoundedRectangle(cornerRadius: 20, style: .continuous)
//            .strokeBorder(Color(singleCornerColor), lineWidth: 10)
//            .background(RoundedRectangle(cornerRadius: 90).fill(Color(singleCornerBackgroundColor)))
//            .frame(width: width, height: height)
//            .offset(x: -width / 2)
//            .offset(y: -height / 2)
//            .clipped()
//            .offset(x: width / 4)
//            .offset(y: height / 4)
//            .frame(width: width / 2)
//            .frame(height: height / 2)
//            .clipped()
//            .scaleEffect(x: scaledEffectX, y: scaledEffectY)
//            .scaledToFit()
//        
//    }
//}
//
//struct OutsideCorner: View{
//    public let width: CGFloat
//    public let height: CGFloat
//    public let scaledEffectX: CGFloat
//    public let scaledEffectY: CGFloat
//    public let singleCornerColor: String
//    public let singleCornerBackgroundColor: String
//    
//    var body: some View{
//        
//        ZStack{
//            
//            //Background
//            HStack{
//                Spacer()
//                Rectangle()
//                    .fill(Color(singleCornerBackgroundColor))
//                    .frame(width: width/6, height: height/2)
//            }.frame(width: width/2, height: height/2)
//            
//            VStack{
//                Spacer()
//                
//                Rectangle()
//                    .fill(Color(singleCornerBackgroundColor))
//                    .frame(width: width/2, height: height/6)
//            }.frame(width: width/2, height: height/2)
//            
//            //Corner
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .strokeBorder(Color(singleCornerColor), lineWidth: 10)
//            
//                .frame(width: width, height: height)
//                .offset(x: -width / 2)
//                .offset(y: -height / 2)
//                .clipped()
//                .offset(x: width / 4)
//                .offset(y: height / 4)
//                .frame(width: width / 2)
//                .frame(height: height / 2)
//                .clipped()
//                .scaleEffect(x: scaledEffectX, y: scaledEffectY)
//                .scaledToFit()
//            
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextBox(textBoxStrokeColor: ColorAsset.BAR_PURPLE, textBoxBackgroundColor: ColorAsset.LIGHT_BEGE, textBoxWidth: 200, textBoxHeight: 300)
//    }
//}
