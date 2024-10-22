FROM rust:bookworm as builder

RUN apt update && apt install git -y

WORKDIR /

RUN git clone https://github.com/smarthome-go/sdk-rs && \
    git clone https://github.com/smarthome-go/cli-rs && \
    cd ./cli-rs && \
    cargo b --release --target-dir=target

RUN cd ./cli-rs && cp ./target/release/smarthome-cli /shome-cli

FROM python:bookworm

COPY --from=builder /shome-cli /bin/shome
COPY ./run.sh /bin/run

COPY ./smarthome.config.toml /root/.config/smarthome-cli-rs/config.toml

RUN apt update && apt install python3 -y

ENTRYPOINT [ "/bin/run" ]
