# FreqTrade-NostalgiaForInfinity

This repository provides Docker images combining [FreqTrade](https://github.com/freqtrade/freqtrade) with [NostalgiaForInfinity](https://github.com/iterativv/NostalgiaForInfinity) trading strategy.

## Docker Images

Docker images are built as a matrix of the last 2 versions of FreqTrade and NostalgiaForInfinity, providing 4 image combinations.

### Available Tags

Images are available in the GitHub Container Registry with the following tag format:
- `ghcr.io/alekc/freqtrade-nostalgiaforinfinity:freqtrade-<FREQTRADE_VERSION>-nfi-<NFI_VERSION>`
- `ghcr.io/alekc/freqtrade-nostalgiaforinfinity:ft-<FREQTRADE_VERSION>-nfi-<NFI_VERSION>` (short form)

Current versions:
- FreqTrade: `2025.10_freqaitorch`, `2025.9.1_freqaitorch`
- NostalgiaForInfinity: `v17.2.12`, `v17.1.270`

### Example Usage

```bash
docker pull ghcr.io/alekc/freqtrade-nostalgiaforinfinity:ft-2025.10_freqaitorch-nfi-v17.2.12
docker run -it ghcr.io/alekc/freqtrade-nostalgiaforinfinity:ft-2025.10_freqaitorch-nfi-v17.2.12
```

## Building Images

Images are built manually via GitHub Actions workflow. To trigger a build:

1. Go to the **Actions** tab
2. Select **Build FreqTrade-NostalgiaForInfinity Docker Images** workflow
3. Click **Run workflow**
4. Select the branch and run

The workflow will build all 4 combinations in the matrix and push them to the GitHub Container Registry.

## Local Development

To build locally:

```bash
docker build --build-arg FREQTRADE_VERSION=2025.10_freqaitorch --build-arg NFI_VERSION=v17.2.12 -t freqtrade-nfi .
```
