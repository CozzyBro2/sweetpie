BOTDIR=~/sweetpie;
TOKEN=$(cat ~/.SECRET);

cd $BOTDIR && luvit src/main.lua $TOKEN