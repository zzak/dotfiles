if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PATH="/usr/local/opt/mongodb-community@3.4/bin:$PATH"
export PATH="/usr/local/opt/redis@4.0/bin:$PATH"

#export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
#export PATH="/usr/local/Cellar/openssl@1.1/1.1.1k/bin:$PATH"

#export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
#export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

#export LDFLAGS="-L/usr/local/Cellar/openssl@1.1/1.1.1k/lib"
#export CPPFLAGS="-I/usr/local/Cellar/openssl@1.1/1.1.1k/include"

#export OPENSSL_DIR="/usr/local/opt/openssl@1.1"
#export OPENSSL_SUPPORT="-I$(OPENSSL_DIR)/include -L$(OPENSSL_DIR)/lib"

#export LDFLAGS="-L/usr/local/opt/postgresql@9.6/lib"
#export CPPFLAGS="-I/usr/local/opt/postgresql@9.6/include"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/zzak/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
