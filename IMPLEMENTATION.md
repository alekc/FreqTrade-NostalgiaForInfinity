# Docker Image Build System

## Overview

This repository implements an automated Docker image build system that combines FreqTrade with the NostalgiaForInfinity trading strategy. The system creates a matrix of images covering the last 2 versions of each project.

## Architecture

### Components

1. **Dockerfile**: Multi-stage Docker build that:
   - Uses FreqTrade base images with freqaitorch support
   - Clones the NostalgiaForInfinity strategy repository
   - Creates symlinks for easy strategy access
   - Follows security best practices (non-root user, minimal packages)

2. **GitHub Actions Workflow**: Automated build pipeline that:
   - Triggers manually via workflow_dispatch
   - Builds 4 image combinations (2×2 matrix)
   - Pushes to GitHub Container Registry (GHCR)
   - Uses Docker layer caching for faster builds
   - Applies descriptive tags for version tracking

### Version Matrix

Current versions:
- **FreqTrade**: 2025.10_freqaitorch, 2025.9.1_freqaitorch
- **NostalgiaForInfinity**: v17.2.12, v17.1.270

This produces 4 image combinations:
1. FreqTrade 2025.10_freqaitorch + NFI v17.2.12
2. FreqTrade 2025.10_freqaitorch + NFI v17.1.270
3. FreqTrade 2025.9.1_freqaitorch + NFI v17.2.12
4. FreqTrade 2025.9.1_freqaitorch + NFI v17.1.270

## Usage

### Triggering a Build

1. Navigate to the repository on GitHub
2. Go to the **Actions** tab
3. Select **Build FreqTrade-NostalgiaForInfinity Docker Images**
4. Click **Run workflow**
5. Select the branch (usually `main` or the current PR branch)
6. Click **Run workflow** button

The workflow will:
- Build all 4 image combinations in parallel
- Push them to GHCR with appropriate tags
- Complete in approximately 10-15 minutes (depending on caching)

### Using the Images

Pull an image:
```bash
docker pull ghcr.io/alekc/freqtrade-nostalgiaforinfinity:ft-2025.10_freqaitorch-nfi-v17.2.12
```

Run an image:
```bash
docker run -it ghcr.io/alekc/freqtrade-nostalgiaforinfinity:ft-2025.10_freqaitorch-nfi-v17.2.12
```

### Image Tags

Each image has two tag formats:
- Long form: `freqtrade-<FREQTRADE_VERSION>-nfi-<NFI_VERSION>`
- Short form: `ft-<FREQTRADE_VERSION>-nfi-<NFI_VERSION>`

Example:
- `freqtrade-2025.10_freqaitorch-nfi-v17.2.12`
- `ft-2025.10_freqaitorch-nfi-v17.2.12`

## Maintenance

### Updating Versions

To update to newer versions:

1. Check for new FreqTrade releases:
   - Visit: https://github.com/freqtrade/freqtrade/releases
   - Look for releases with `_freqaitorch` Docker tags

2. Check for new NostalgiaForInfinity releases:
   - Visit: https://github.com/iterativv/NostalgiaForInfinity/releases
   - Note the tag names (e.g., v17.3.x)

3. Update the workflow file `.github/workflows/build-docker-images.yml`:
   - Modify the `matrix.freqtrade_version` array
   - Modify the `matrix.nfi_version` array
   - Keep only the last 2 versions of each

4. Update the README.md to reflect current versions

5. Commit and push changes

6. Trigger a manual workflow run

### Security

The build system follows security best practices:
- Non-root user execution (ftuser)
- Minimal package installation
- No suggested packages installed
- Regular base image updates via FreqTrade
- Automated security scanning via CodeQL

## Troubleshooting

### Build Failures

**Issue**: Workflow fails during image build
- Check Docker build logs in the Actions tab
- Verify that both FreqTrade and NFI versions exist
- Ensure base image is accessible from GHCR

**Issue**: Permission denied when pushing to GHCR
- Verify repository permissions for GitHub Actions
- Ensure GITHUB_TOKEN has `packages: write` permission

**Issue**: Git checkout fails in Dockerfile
- Verify NFI version tag exists in the repository
- Check network connectivity to github.com

### Image Issues

**Issue**: Strategy files not found in container
- Verify symlinks were created correctly
- Check `/freqtrade/user_data/strategies/` directory
- Ensure git checkout succeeded

**Issue**: FreqTrade version mismatch
- Verify the FREQTRADE_VERSION build arg
- Check if the tag exists in ghcr.io/freqtrade/freqtrade
- Update to a valid freqaitorch tag

## Future Improvements

Possible enhancements:
1. Add automated version detection to always build latest 2 releases
2. Implement scheduled builds (weekly/monthly)
3. Add image vulnerability scanning
4. Create separate workflows for testing vs production
5. Add build notifications (Slack/Discord)
6. Implement multi-architecture builds (arm64 support)
