# Changelog

## Unreleased

### Changed
- Upgraded base image from `ubuntu:18.04` to `ubuntu:24.04` (LTS, supported until 2029)
- Replaced deprecated `MAINTAINER` instruction with `LABEL maintainer=`
- Consolidated all `RUN` commands into a single layer to reduce image size
- Replaced GitHub git clones of noVNC and websockify with `novnc` and `python3-websockify` apt packages, eliminating SSL certificate failures during build
- Updated noVNC proxy path in `supervisord.conf` from `/opt/noVNC/utils/novnc_proxy` to `/usr/share/novnc/utils/novnc_proxy` to match apt install location
- Pinned build and runtime platform to `linux/amd64` to fix IPMIView crash (SIGTRAP) on Apple Silicon hosts
- Updated Makefile image name from `sunfoxcz/ipmiview` to `lordbink/ipmiview` for forked repo
- Added `make run` target to Makefile with correct `--platform linux/amd64` flag
- Updated README clone URL and `docker run` command to use forked repo (`lordbink/ipmiview`)
- Replaced `docker run` command in README with `make run`

### Added
- `ca-certificates` package added to fix SSL certificate verification failures
- Firefox ESR via Mozilla's official apt repository (later removed; see below)

### Removed
- Firefox ESR and Mozilla apt repository setup removed — Firefox is not used by any supervised service and introduced build failures due to SSL certificate issues in the Docker build environment
- `software-properties-common` removed (no longer needed without PPA management)
- `git` removed from final image (no longer needed after switching to apt-packaged noVNC)
- `curl` removed from final image
