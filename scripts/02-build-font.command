#!/usr/bin/env bash
dir=${0%/*}; if [ "$dir" = "$0" ]; then dir="."; fi; cd "$dir";

cd ..
mkdir -p build
mkdir -p fonts/variable

python3 -m fontTools.varLib.instancer -o "build/FlexlabHead[wght,wdth]-full.ttf" \
	"sources/roboto-flex/fonts/variable/RobotoFlex[GRAD,XOPQ,XTRA,YOPQ,YTAS,YTDE,YTFI,YTLC,YTUC,opsz,slnt,wdth,wght].ttf" \
	wght=200:1000 \
	wdth=25:150 \
	opsz=30 \
	slnt=0 \
	GRAD=0 \
	XOPQ=96 \
	YOPQ=79 \
	XTRA=468 \
	YTAS=663 \
	YTDE=-180 \
	YTFI=676 \
	YTLC=514 \
	YTUC=650

# python3 -m fontTools.varLib.instancer -o "build/FlexlabHead[wght,wdth]-full.ttf" \
# 	"sources/roboto-flex/fonts/variable/RobotoFlex[GRAD,XOPQ,XTRA,YOPQ,YTAS,YTDE,YTFI,YTLC,YTUC,opsz,slnt,wdth,wght].ttf" \
# 	wght=200:900 \
# 	wdth=25:150 \
# 	opsz=30 \
# 	XTRA=468 \
# 	slnt=0 \
# 	GRAD=0 \
# 	XOPQ=96 \
# 	YOPQ=79 \
# 	YTAS=663 \
# 	YTDE=-180 \
# 	YTFI=676 \
# 	YTLC=514 \
# 	YTUC=650

Echo "Subsetting font..."

python3 -m fontTools.subset --text-file="scripts/subset.utf8.txt" --output-file="build/FlexlabHead[wght,wdth].ttf" "build/FlexlabHead[wght,wdth]-full.ttf"

Echo "Patching names..."

python3 -m fontTools.ttx -o "fonts/variable/FlexlabHead[wght,wdth].ttf" -m "build/FlexlabHead[wght,wdth].ttf" "sources/FlexlabHead[wght,wdth]-naming.ttx"

open "fonts/variable/"
