import Foundation
import NotesCore


let timeService = TimeService()
let date = timeService.convertStringToDate(source: "2017-01-27 18:36:36")
print(String(describing: date))

