FROM erlang:24

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.12.2" \
	LANG=C.UTF-8

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& mkdir -p /usr/local/elixir \
	&& tar -xzC /usr/local/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/elixir \
	&& make install clean \
	&& find /usr/local/elixir/ -type f -not -regex "/usr/local/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
	&& find /usr/local/elixir/ -type d -depth -empty -delete
