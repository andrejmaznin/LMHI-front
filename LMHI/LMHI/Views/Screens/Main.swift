import SwiftUI

struct Main: View {
    var body: some View {
        VStack {
            HStack {
                Text("Fast Access")
                    .font(.system(size: 36, weight: .bold, design: .default))
                
                Spacer()
            }
            .padding()
            
            GeometryReader { metrics in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Rectangle()
                                .frame(width: 150)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(20.0)
                            
                            Rectangle()
                                .frame(width: 150)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(20.0)
                            
                            Rectangle()
                                .frame(width: 150)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(20.0)
                        }
                        .padding()
                    }
                    .frame(width: metrics.size.width, height: metrics.size.height / 3)

                    Rectangle()
                        .cornerRadius(20.0)
                        .padding()
                        .frame(width: metrics.size.width)
                        .aspectRatio(contentMode: .fill)
                }
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
            
    }
}
