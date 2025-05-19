FROM archlinux:base-devel

COPY ./scripts/build.sh /build.sh

RUN useradd --create-home builder
RUN echo "builder ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

USER builder
ENTRYPOINT [ "/build.sh" ]
