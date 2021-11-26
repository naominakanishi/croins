class StringTracker {
    var frameIndex: Int64 = 0

    typealias StringObservation = (lastSeen: Int64, count: Int64)
    
    var seenStringsDate = [String: StringObservation]()
    var seenStringsCurrency = [String: StringObservation]()
    var bestCountDate = Int64(0)
    var bestCountCurrency = Int64(0)
    var bestStringDate = ""
    var bestStringCurrency = ""

    func logFrame(strings: [[String]]) {
        for (i, value) in strings.enumerated() {
            for string in value {
                if i == 0 { // Date
                    if seenStringsDate[string] == nil {
                        seenStringsDate[string] = (lastSeen: Int64(0), count: Int64(-1))
                    }
                    seenStringsDate[string]?.lastSeen = frameIndex
                    seenStringsDate[string]?.count += 1
                }
                if i == 1 { // Value
                    if seenStringsCurrency[string] == nil {
                        seenStringsCurrency[string] = (lastSeen: Int64(0), count: Int64(-1))
                    }
                    seenStringsCurrency[string]?.lastSeen = frameIndex
                    seenStringsCurrency[string]?.count += 1
                }
            }
        }
    
        var obsoleteStringsDate = [String]()
        var obsoleteStringsCurrency = [String]()
        
        for (string, obs) in seenStringsDate {
            if obs.lastSeen < frameIndex - 30 {
                obsoleteStringsDate.append(string)
            }
            let count = obs.count
            if !obsoleteStringsDate.contains(string) {
                if count > bestCountDate {
                    bestCountDate = Int64(count)
                    bestStringDate = string
                }
            }
        }
        for (string, obs) in seenStringsCurrency {
            if obs.lastSeen < frameIndex - 30 {
                obsoleteStringsCurrency.append(string)
            }
            let count = obs.count
            if !obsoleteStringsCurrency.contains(string) {
                if count > bestCountCurrency {
                    bestCountCurrency = Int64(count)
                    bestStringCurrency = string
                }
            }
        }
        
        for string in obsoleteStringsDate {
            seenStringsDate.removeValue(forKey: string)
        }
        for string in obsoleteStringsCurrency {
            seenStringsCurrency.removeValue(forKey: string)
        }
        
        frameIndex += 1
    }
    
    func getStableString() -> [String]? {
        print(bestCountDate, bestCountCurrency)
        if bestCountDate >= 10 && bestCountCurrency >= 10 {
            return [bestStringDate, bestStringCurrency]
        } else {
            return nil
        }
    }
    
    func reset(string: [String]) {
        for individualString in string {
            if seenStringsDate.keys.contains(individualString) {
                seenStringsDate.removeValue(forKey: individualString)
            }
            if seenStringsCurrency.keys.contains(individualString) {
                seenStringsCurrency.removeValue(forKey: individualString)
            }
        }
        bestCountDate = 0
        bestCountCurrency = 0
        bestStringDate = ""
        bestStringCurrency = ""
    }
}
