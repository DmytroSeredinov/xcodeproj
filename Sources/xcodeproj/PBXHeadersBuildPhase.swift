import Foundation
import Unbox
import PathKit

// This is the element for the framewrok link build phase.
public class PBXHeadersBuildPhase: PBXBuildPhase, Hashable {
    
    public static func == (lhs: PBXHeadersBuildPhase,
                           rhs: PBXHeadersBuildPhase) -> Bool {
        return lhs.reference == rhs.reference &&
            lhs.buildActionMask == rhs.buildActionMask &&
            lhs.files == rhs.files &&
            lhs.runOnlyForDeploymentPostprocessing == rhs.runOnlyForDeploymentPostprocessing
    }
}

// MARK: - PBXHeadersBuildPhase Extension (Extras)

extension PBXHeadersBuildPhase {
    
    /// Returns if the path refers to a header file.
    ///
    /// - Parameter path: path to be checked.
    /// - Returns: true if the path points to a header file.
    static func isHeader(path: Path) -> Bool {
        return path.extension.flatMap({isHeader(fileExtension: $0)}) ?? false
    }
    
    /// Returns if the given extension is a header.
    ///
    /// - Parameter fileExtension: file extension to be checked.
    /// - Returns: true if the file represents a header.
    static func isHeader(fileExtension: String) -> Bool {
        let headersExtensions = ["h", "hh", "hpp", "ipp", "tpp", "hxx", "def"]
        return headersExtensions.contains(fileExtension)
    }
    
}

// MARK: - PBXHeadersBuildPhase Extension (PlistSerializable)

extension PBXHeadersBuildPhase: PlistSerializable {
    
    func plistKeyAndValue(proj: PBXProj) -> (key: CommentedString, value: PlistValue) {
        var dictionary: [CommentedString: PlistValue] = plistValues(proj: proj)
        dictionary["isa"] = .string(CommentedString(PBXHeadersBuildPhase.isa))
        return (key: CommentedString(self.reference, comment: "Frameworks"), value: .dictionary(dictionary))
    }
    
}
