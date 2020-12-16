if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PATH="/usr/local/opt/mongodb-community@3.4/bin:$PATH"
export PATH="/usr/local/opt/redis@4.0/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/postgresql@9.6/lib"
export CPPFLAGS="-I/usr/local/opt/postgresql@9.6/include"


