{\rtf1\ansi\ansicpg1252\cocoartf2709
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\csgray\c0;}
\margl1440\margr1440\vieww20120\viewh10680\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs22 \cf2 \CocoaLigature0 \
# This code line directs the BirdNet algorithm to analyze files \
# in input folder `i`, then it exports those files to output folder `o`.\
# In this case I ran latitude, longitude, and time of year unrestricted\
# which allows us to maximize detections of rare species.\
\
python3 analyze.py --i /Users/amy/Desktop/test_dir/input --o /Users/amy/Desktop/test_dir/output --lat -1 --lon -1 --week -1\
\
\
# This line allows you to batch process multiple folders (creates its own folders). \
# Update your folder paths accordingly. \
\
python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-30625B --o /Volumes/ExtremeSSD/Mojave/birds/BD-30625B --lat -1 --lon -1 --week -1 &\
wait; python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-30739A --o /Volumes/ExtremeSSD/Mojave/birds/BD-30739A --lat -1 --lon -1 --week -1 &\
wait; python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-30739B --o /Volumes/ExtremeSSD/Mojave/birds/BD-30739B --lat -1 --lon -1 --week -1 &\
wait; python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-30925A --o /Volumes/ExtremeSSD/Mojave/birds/BD-30925A --lat -1 --lon -1 --week -1 &\
wait; python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-30925B --o /Volumes/ExtremeSSD/Mojave/birds/BD-30925B --lat -1 --lon -1 --week -1 &\
wait; python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-31457A --o /Volumes/ExtremeSSD/Mojave/birds/BD-31457A --lat -1 --lon -1 --week -1 &\
wait; python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-31457B --o /Volumes/ExtremeSSD/Mojave/birds/BD-31457B --lat -1 --lon -1 --week -1 &\
wait; python3 analyze.py --i /Volumes/ExtremeSSD/Mojave/birds/BD-32379A --o /Volumes/ExtremeSSD/Mojave/birds/BD-32379A --lat -1 --lon -1 --week -1}
