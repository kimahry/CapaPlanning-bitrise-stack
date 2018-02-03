FROM bitriseio/docker-bitrise-base:latest

# Install last Erlang and Elixir version
RUN apt-get update && apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev inotify-tools \
&& git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.1 \
&& echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc \
&& echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc \
&& source ~/.bashrc \
&& asdf plugin-add erlang && asdf install erlang 20.2 \
&& asdf plugin-add elixir && asdf install elixir 1.6.0 \
&& asdf global erlang 20.2 && asdf global elixir 1.6.0

# Install Phoenix tools
RUN mix local.hex --force && mix local.rebar --force

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y google-chrome-stable
 