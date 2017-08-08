پيش نياز
sudo apt-get update; sudo apt-get upgrade; sudo apt-get install tmux; sudo apt-get install luarocks; sudo apt-get install screen; sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev; sudo apt-get update; sudo apt-get install; sudo apt-get install upstart-sysv
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz;tar zxpf luarocks-2.2.2.tar.gz;cd luarocks-2.2.2 && ./configure; sudo make bootstrap;sudo luarocks install luasocket;sudo luarocks install luasec;sudo luarocks install redis-lua;sudo luarocks install lua-term;sudo luarocks install serpent;sudo luarocks install dkjson;sudo luarocks install lanes;sudo luarocks install Lua-cURL
cd ..



git clone https://github.com/mohammadrassoul/R7

7️⃣ دستورات زیر در ترمینال وارد کنید ...
cd MaTaDoR/cli

chmod +x matador.sh

chmod 777 auto.sh && sed -i -e 's/\r$//' auto.sh

./matador.sh install 

 ./matador.sh

صبر میکنیم تا کامل نصب بشه 

شماره ربات وارد مکنید کد میزنید‌
از سرور خارج و دوباره وصل میشید...
کد های زیر را در سرور میزنیم 
cd R7/api

chmod +x matador.sh

chmod 777 auto.sh && sed -i -e 's/\r$//' auto.sh
./matador.sh install
./matador.sh
صبر کنید تموم شه ، بعد ترمینال رو ببندید .


حالا ربات اماده لانچ کردنه :
cd R7/api && chmod +x auto.sh && chmod 777 auto.sh && screen ./auto.sh

یه ترمینال دیگه باز کنید و این رو بزنید : 
cd R7/cli && chmod +x auto.sh && chmod 777 auto.sh && screen ./auto.sh 

تموم . میتونید از سرور خارج شید .

