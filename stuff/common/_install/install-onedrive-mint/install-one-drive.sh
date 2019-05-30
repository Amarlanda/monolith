# this is the solution as of Thursaday march 7 2019

#URL - https://www.maketecheasier.com/sync-onedrive-linux/

snap install --classic dmd && sudo snap install --classic dub

git clone https://github.com/skilion/onedrive.git
cd onedrive
make
sudo make install
