import SwiftUI

public struct NLoader: View {
    public init() {}
    
    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(NColors.backgroundInverse)
            .scaleEffect(2)
    }
}

struct NLoader_Previews: PreviewProvider {
    static var previews: some View {
        NLoader()
    }
}
