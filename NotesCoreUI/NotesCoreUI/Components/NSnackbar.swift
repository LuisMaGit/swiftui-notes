import SwiftUI

enum NSnackbarType {
    case verbose
    case error
}

struct NSnackbar: View {
    let title: LocalizedStringKey
    let height: Double
    let type: NSnackbarType

    init(
        title: LocalizedStringKey,
        height: Double = 50,
        type: NSnackbarType = .verbose
    ) {
        self.title = title
        self.height = height
        self.type = type
    }

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(
                cornerRadius: NBorderRadius.k10
            )
            .fill(getColor)
            NText(
                key: title,
                color: getTextColor
            )
            .padding(.leading, NSpace.k16)
        }
        .frame(
            height: height
        )
    }

    var getColor: Color {
        switch type {
        case .verbose:
            return NColors.backgroundLighterInverse
        case .error:
            return NColors.backgroundInverse
        }
    }

    var getTextColor: Color {
        switch type {
        case .verbose:
            return NColors.backgroundLighter
        case .error:
            return NColors.redPink
        }
    }
}

struct NSnackbar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NSnackbar(title: "Verbose")
            NSnackbar(title: "Error", type: .error)
        }
    }
}
