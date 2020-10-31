# docker run --detach --rm --env=DISPLAY=:0.0 -v /tmp/.X11-unix:/tmp/.X11-unix --env=PULSE_SERVER=unix:/run/user/${UID}/pulse/native --env=TZ=Europe/Berlin -v /run/user/${UID}/pulse:/run/user/${UID}/pulse -v chromium-conf:/home/chromium/.config/chromium/ --device /dev/dri --device /dev/video0 --device /dev/video1 --shm-size=512m --security-opt seccomp=${HOME}/development/chromium-container/chrome.json --security-opt no-new-privileges --group-add 44 chromium

FROM fedora:33
# For non-rawhide updates not yet in stable: --enablerepo=updates-testing
RUN dnf -y --enablerepo=updates-testing install \
    chromium \
    gnu-free-sans-fonts \
    google-noto-emoji-color-fonts \
    libglvnd-glx \
    mesa-dri-drivers \
    vlgothic-fonts \
    && dnf clean all
RUN groupadd -g 1000 chromium \
    && useradd -u 1000 -n -g chromium -G audio,video chromium \
    && mkdir -p /home/chromium/Downloads /home/chromium/.config/chromium \
    && chown -R chromium:chromium /home/chromium
USER chromium
ENTRYPOINT ["chromium-browser"]