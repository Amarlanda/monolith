
git init ~/linux-priv/
git  diff
cd ~/linux-priv/
git add .
read -p 'commit message: ' var
git commit -m "auto commit - $var - $(date)"
git push -u origin master
echo "10"

clear
python3 ~/linux-priv/python3.py
