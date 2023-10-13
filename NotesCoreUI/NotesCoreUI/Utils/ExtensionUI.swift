import SwiftUI

public extension View {
    func nHPadding() -> some View {
        return self.padding(.horizontal, NSpace.k16)
    }
}
