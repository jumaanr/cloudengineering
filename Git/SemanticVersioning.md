# Semantic Versioning

**Semantic Versioning** (often abbreviated as **SemVer**) is a versioning system for software that helps to communicate changes in a predictable, structured way. It follows a standard convention to label versions using a three-part numbering system: **MAJOR.MINOR.PATCH** (e.g., `1.2.3`).

### Breakdown of the Version Format:
```
MAJOR.MINOR.PATCH
```

1. **MAJOR version**: Increments when you make **incompatible changes** that break backward compatibility.
   - Example: `1.0.0` → `2.0.0`
   - Example Scenarios: Removing functionality, changing the API in a way that requires updates in dependent code.

2. **MINOR version**: Increments when you add **new functionality** in a backward-compatible manner.
   - Example: `1.0.0` → `1.1.0`
   - Example Scenarios: Adding new features or enhancements that do not break the existing API or functionality.

3. **PATCH version**: Increments when you make **backward-compatible bug fixes**.
   - Example: `1.0.0` → `1.0.1`
   - Example Scenarios: Bug fixes, security patches, or minor changes that do not affect the functionality.

### Rules of Semantic Versioning:
- **Initial Development (0.x.x)**: During the initial development, the version is `0.x.x`. Anything may change at any time. The `0` major version is for experimental or development stages.
- **Stable Release (1.0.0)**: Once the version reaches `1.0.0`, it signifies a stable release, and subsequent changes follow the rules of incrementing MAJOR, MINOR, and PATCH versions.

### Semantic Versioning Example:
- `1.0.0`: Initial stable release.
- `1.1.0`: A new feature is added (backward-compatible).
- `1.1.1`: A bug fix is applied.
- `2.0.0`: An incompatible API change is made, requiring a major version increment.

### Why Use Semantic Versioning?
- **Clarity**: It clearly communicates what kind of changes have been made.
- **Predictability**: Developers can predict whether updating to a new version will break their existing implementation or not.
- **Dependency Management**: It helps when managing dependencies in a project by knowing whether it’s safe to update to a newer version of a library.
  
### Version Ranges:
Semantic versioning also makes it easier to define version ranges when depending on third-party libraries. For example, `^1.2.3` means that any version from `1.2.3` to `1.x.x` (excluding major version `2.0.0`) is acceptable, as minor and patch changes are backward-compatible.

### Conclusion:
Semantic versioning is a widely adopted convention in software development that simplifies the process of versioning software in a consistent and transparent way, reducing confusion for developers and users when upgrading software.

# Label Versioning
In **Semantic Versioning (SemVer)**, a **label element** is used to indicate **pre-release versions** or **build metadata**. These elements provide additional context about the version beyond the standard **MAJOR.MINOR.PATCH** structure.

### Types of Label Elements in Semantic Versioning:

1. **Pre-release Label**:
   - Used to mark versions that are **not ready for production** (e.g., alpha, beta, or release candidates).
   - Follows the `PATCH` version and is separated by a hyphen (`-`).
   - Pre-release versions have **lower precedence** than the associated MAJOR.MINOR.PATCH version. This allows for testing or development without affecting the stability of the main release.

   **Format**:
   ```
   MAJOR.MINOR.PATCH-<pre-release-label>
   ```
   
   **Examples**:
   - `1.0.0-alpha`
   - `1.0.0-beta.1`
   - `2.1.0-rc.2`
   
   **Common Pre-release Identifiers**:
   - `alpha`: Early stage testing or development.
   - `beta`: More stable than alpha, but still in testing.
   - `rc` (Release Candidate): Nearly ready for release, but final testing is still required.

2. **Build Metadata**:
   - Used to indicate **build information** that doesn’t affect version precedence.
   - Follows the version or pre-release label and is separated by a plus sign (`+`).
   - Build metadata is **ignored when determining version precedence** but is useful for identifying specific builds (e.g., build numbers, commit hashes).

   **Format**:
   ```
   MAJOR.MINOR.PATCH+<build-metadata>
   ```
   
   **Examples**:
   - `1.0.0+build.123`
   - `1.0.0-alpha+exp.sha.5114f85`
   - `2.1.0+20230915`

### Full Semantic Version Example with Labels:
- `1.0.0-alpha.1+build.001`

In this example:
- `1.0.0`: The standard version number (MAJOR.MINOR.PATCH).
- `alpha.1`: Indicates it's an early test release (alpha, first iteration).
- `build.001`: Provides additional information about the build.

### Key Points:
- **Pre-release labels** determine **precedence**; for example, `1.0.0-alpha` < `1.0.0-beta` < `1.0.0`.
- **Build metadata** is for **informational purposes only** and doesn’t affect precedence. For example, `1.0.0+build.1` is considered the same version as `1.0.0`.

### Usage Scenarios:
- **Pre-release versions** are typically used when you're developing software but want to make it available for testing or feedback before the official release.
- **Build metadata** helps to track specific builds or deployments without altering the core version number.

In summary, **labels** in Semantic Versioning help differentiate versions in development stages and provide additional metadata, ensuring clarity during software development and deployment.
