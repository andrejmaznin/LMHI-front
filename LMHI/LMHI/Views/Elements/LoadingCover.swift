import SwiftUI

struct LoadingCover: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var isPresented: Bool = true
    var backgroundOpacity: CGFloat = 0.3
    var cornerRadius: CGFloat = 10.0
    var shadowRadius: CGFloat = 20.0
    var progressIconScale: CGFloat = 2.0
    var width: CGFloat = 200.0
    var height: CGFloat = 100.0
    
    var body: some View {
        Group {
            if isPresented {
                ZStack {
                    Color(.black)
                        .ignoresSafeArea(.all)
                        .opacity(backgroundOpacity)
                    
                    Group {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(colorScheme == .dark ? Color("Madison") : .white)
                            .shadow(radius: shadowRadius)
                        
                        VStack {
                            ProgressView()
                                .scaleEffect(progressIconScale)
                            
                            Text("Loading...")
                                .font(Fonts.boldCaption)
                                .padding(.top, height / 5.0)
                        }
                    }
                    .frame(width: width, height: height)
                }
            }
        }
    }
}

struct LoadingCover_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCover()
    }
}
