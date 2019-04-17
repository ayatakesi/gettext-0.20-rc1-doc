#!/bin/sh

for TEXI in $(ls original_texis/*.texi)
do
    TEXI=$(basename ${TEXI})
    if [ -f ~/gitroot/gettext-0.19.8.1-doc/${TEXI}.po ];
    then
	
	# POTファイルの作成

	 po4a-gettextize \
	     -M utf8 \
	     -f texinfo \
	     -m original_texis/${TEXI} \
	     -p ${TEXI}.pot

	# gettext-0.19.8.1-doc翻訳をマージ
	msgmerge \
	    --previous --compendium \
	    ~/gitroot/gettext-0.19.8.1-doc/${TEXI}.po \
	    -o - /dev/null ${TEXI}.pot |
	    msgcat --no-wrap - > ${TEXI}.po
    fi
    
done
