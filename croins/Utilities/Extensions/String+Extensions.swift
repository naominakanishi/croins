extension String {
    func extractDate() -> (Range<String.Index>, String)? {
        let pattern = "[0-9]{2}[/][0-9]{2}[/][0-9]{2,4}"
        
        guard let range = self.range(of: pattern, options: .regularExpression, range: nil, locale: nil) else {
            return nil
        }
        
        let dateSubstring = String(self[range])
        
        guard dateSubstring.count == 8 || dateSubstring.count == 10 else {
            return nil
        }
        
        var result = ""
        let allowedChars = "0123456789/"
        for var char in dateSubstring {
            char = char.getSimilarCharacterIfNotIn(allowedChars: allowedChars)
            guard allowedChars.contains(char) else {
                return nil
            }
            result.append(char)
        }
        return (range, result)
    }
    
    func extractValues() -> (Range<String.Index>, String)? {
        let pattern = "([0-9]+,[0-9]{2})"
        
        guard let range = self.range(of: pattern, options: .regularExpression, range: nil, locale: nil) else {
            return nil
        }
        
        let valuesSubstring = String(self[range])
        
        var result = ""
        let allowedChars = "0123456789,"
        for var char in valuesSubstring {
            char = char.getSimilarCharacterIfNotIn(allowedChars: allowedChars)
            guard allowedChars.contains(char) else {
                return nil
            }
            result.append(char)
        }
        return (range, result)
    }
}
