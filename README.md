<p 
    <div align="center">
    <a href="https://telegram.me/matadorteam">
        <img src="http://upir.ir/951/guest/Untitled-7.png" hspace="10" width="150">
    </a>
    <a href="https://telegram.me/mahdiroo">
        <img src="http://upir.ir/951/guest/Untitled-6.png" width="150">
    </a>
</div>
<a href="https://telegram.me/matadorteam"><font size="100">MaTaDoR BoT v5.7</font></a>
<br>
<h3 align="right"> <strong></strong>
</h3>
<hr>
</pre>
<h4 dir="rtl">پیش نیاز های سورس ماتادور =))
</h4>
<pre>
<span>
sudo apt-get update; sudo apt-get upgrade; sudo apt-get install tmux; sudo apt-get install luarocks; sudo apt-get install screen; sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev; sudo apt-get update; sudo apt-get install; sudo apt-get install upstart-sysv
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz;tar zxpf luarocks-2.2.2.tar.gz;cd luarocks-2.2.2 && ./configure; sudo make bootstrap;sudo luarocks install luasocket;sudo luarocks install luasec;sudo luarocks install redis-lua;sudo luarocks install lua-term;sudo luarocks install serpent;sudo luarocks install dkjson;sudo luarocks install lanes;sudo luarocks install Lua-cURL
cd ..
</span>
</pre>
<hr>
<h3 align="right"> <strong>نصب</strong> 🚀
<h4 dir="rtl">نصب ربات(ساده ترین روش)
<br></h4>
<h6 dir="rtl"></h6>
<pre>
<span>cd $HOME && git clone https://github.com/mohammadrassoul/R7</span>
</pre>

2️⃣** سپس سورس را کلون میکنیم :
git clone https://github.com/MaTaDoRTeaM/MaTaDoR
======================
3️⃣ وارد شماره‌ ربات میشویم و  یه ربات (api) با
 @Botfather 
میسازیم اسم و ایدی وارد میکنیم (سپس باید اینلاین را فعال کنیم 
/setinline
 میزنیم و بعد ایدی ربات رو میزنیم در اخر یه ok میفرسیم‌)
======================
4️⃣ سپس‌ با شماره ربات، ربات
 @userinfobot 
را استارت کرده و ایدی عددی شماره ربات را کپی میکنیم کرده ...
======================
5️⃣ وارد مسیر زیر میشویم**
MaTaDoR/api/bot/bot.lua
در خط [3] توکن ربات (api) که مرحله سوم با شماره ربات ساخیم وارد میکنیم.
در خط [5] ایدی سودو اصلی یعنی خودتون قرار میدید .
در خط [165] ایدی سودو اصلی یعنی خودتون و ایدی ربات cli ینی ایدی تلگرام رباتتون رو قرار میدید . اگر سه تا عدد پیشفرض نوشته بود مال خودتونو جاگزین کنید سومی رو پاک کنید .
سیو میکنیم‌ خارج میشیم‌ ....
======================
6️⃣ وارد مسیر زیر میشیم‌
MaTaDoR/cli/plugins/Tools
در خط [2] ایدی عددی سودو قرار میدهید .
سیو میکنم‌ خارج میشیم‌....
سپس وارد مسیر زیر میشویم 
MaTaDoR/cli/bot/bot.lua
و بعد در خط [17] ایدی ربات (api) را وارد میکنیم توجه داشته باشید ایدی عددی ربات (api) اول توکن نوشته شده است .
در خط 95 دوتا ایدی پیشفرض نوشته شما ایدی خودتون و ایدی ربات cli رو باهاش جایگزین کنید .
سیو میکنم‌ خارج میشیم‌....
======================
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

توجه داشته باشید بعد از لانچ شدن ربات (api) یا همون هلپر وارد شماره ربات میشم و ربات (api) که در مرحله سوم ساختیم /start میکنیم ...
====================
