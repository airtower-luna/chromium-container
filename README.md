# Docker container for the Fedora Chromium package

This is my workaround to run Chromium on distributions that don't
offer Chromium at all, or only an outdated package. Build the
container as usual, add a tag if you like:

```
docker build -t chromium .
```

The build will install the latest available Chromium package for the
Fedora version set in the Dockerfile. You can check the latest
versions and their release notes [in the Fedora Updates
System](https://bodhi.fedoraproject.org/updates/?packages=chromium). Note
that if you're rebuilding the container for a Chromium package update
(without any change to the `dnf install` command) you'll need to use
the `--no-cache` option to make sure the layer with the same install
command from an older version of the container doesn't get reused.

The seccomp profile in [`chrome.json`](./chrome.json) is by Jessie
Frazelle, likewise under MIT license. See
https://github.com/jessfraz/dotfiles/blob/master/etc/docker/seccomp/chrome.json
for the original.
