#!/usr/bin/env bash
dir=${0%/*}
if [ "$dir" = "$0" ]; then dir="."; fi
cd "$dir"

cd ..
mkdir -p build
mkdir -p fonts/variable

python3 -m fontTools.varLib.instancer -o "build/FlexlabTemp[wght,wdth]-full.ttf" \
"sources/roboto-flex/fonts/RobotoFlex[GRAD,XOPQ,XTRA,YOPQ,YTAS,YTDE,YTFI,YTLC,YTUC,opsz,slnt,wdth,wght].ttf" \
opsz=30 \
slnt=0 \
wdth=100:140 \
wght=200:1000 \
GRAD=0 \
XOPQ=96 \
XTRA=468 \
YOPQ=79 \
YTAS=663 \
YTDE=-180 \
YTFI=676 \
YTLC=514 \
YTUC=650

# python3 -m fontTools.varLib.instancer -o "build/FlexlabTemp[wght,wdth]-full.ttf" \
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

python3 -m fontTools.subset --text-file="scripts/subset.utf8.txt" --output-file="build/FlexlabTemp[wght,wdth].ttf" "build/FlexlabTemp[wght,wdth]-full.ttf"

Echo "Making instances..."

python3 -m fontTools.varLib.instancer -o "fonts/FlexlabTemp-ExtraLight.ttf" \
"build/FlexlabTemp[wght,wdth].ttf" wdth=140 wght=200

python3 -m fontTools.varLib.instancer -o "fonts/FlexlabTemp-Regular.ttf" \
"build/FlexlabTemp[wght,wdth].ttf" wdth=140 wght=400

python3 -m fontTools.varLib.instancer -o "fonts/FlexlabTemp-Bold.ttf" \
"build/FlexlabTemp[wght,wdth].ttf" wdth=140 wght=700

python3 -m fontTools.varLib.instancer -o "fonts/FlexlabTemp-ExtraBlack.ttf" \
"build/FlexlabTemp[wght,wdth].ttf" wdth=140 wght=1000

open "fonts/"
