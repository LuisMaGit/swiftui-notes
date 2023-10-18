import Combine
import Foundation

public class SnackbarService: ObservableObject {
    public static let instance: SnackbarService = .init()

    @Published public var type: SnackbarType = .none
    private var timerCancellable: AnyCancellable?

    private init() {}

    public func showSnackbar(_ value: SnackbarType) {
        if type != .none {
            return
        }
        updateType(value)
        let timer = Timer.publish(
            every: 2,
            on: .main,
            in: .common
        ).autoconnect()
        timerCancellable = timer.sink(
            receiveValue: { [weak self] _ in
                self?.updateType(.none)
                self?.timerCancellable?.cancel()
            }
        )
    }

    private func updateType(_ value: SnackbarType) {
        DispatchQueue.main.async { [weak self] in
            self?.type = value
        }
    }
}
