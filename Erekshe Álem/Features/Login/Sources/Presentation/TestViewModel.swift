import SwiftUI

@MainActor
final class TestViewModel: ObservableObject {
    // MARK: Params
    @Published private var model: TestModel

    // MARK: Init
    init(dependencies: Dependencies) {
        self.model = TestModel()
    }
}

// MARK: - Dependencies
extension TestViewModel {
    struct Dependencies {
        let 
        init() {
            
        }
    }
}
