cd /d %~dp0
cd aa
@echo off

::start download

wget -O i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
wget -O i2.txt https://halflife.coding.net/p/list/d/list/git/raw/master/ad-pc.txt
wget -O i3.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
wget -O i4.txt https://banbendalao.coding.net/p/adgk/d/ADgk/git/raw/master/ADgk.txt
wget -O i5.txt https://neodev.team/lite_adblocker
wget -O i6.txt http://file.trli.club/dns/hosts.txt
wget -O i7.txt https://adaway.org/hosts.txt
wget -O i8.txt https://anti-ad.net/adguard.txt
wget -O i9.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/rule.txt


::add new rules
::wget -O i+number url

::end download

::no need to change
del /f /q *.html
del /f /q *hsts

::TheRuleMaker
::No need to change

::Merge
type frules.dd>mergd.txt
type i*.txt>>mergd.txt

::nore
gawk "!a[$0]++" mergd.txt>nore.txt

::del comments
(FOR /F "eol=# delims=" %%i in (nore.txt) do (echo %%i))>ktmp.txt
(FOR /F "eol=[ delims=" %%i in (ktmp.txt) do (echo %%i))>stmp.txt
(FOR /F "eol=! delims=" %%i in (stmp.txt) do (echo %%i))>nord.txt

::add title and date
echo ! Version: %date%>>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
copy title.dd+tpdate.txt+nord.txt+brules.dd final.txt

::end
copy /y final.txt ..\..\AdKillRules.txt
del /f /q *.txt&exit
