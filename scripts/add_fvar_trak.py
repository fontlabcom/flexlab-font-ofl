#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from fontTools.ttLib import TTFont
from fontTools.ttLib.tables._f_v_a_r import Axis
import fontTools.ttLib.tables.TupleVariation as tv
import argparse

TupleVariation = tv.TupleVariation

parser = argparse.ArgumentParser(description="Add a TRAK axis")
parser.add_argument("-o", "--output", help="output font file")
parser.add_argument("font", help="font to add the axis to")

args = parser.parse_args()

font = TTFont(args.font)

if "fvar" not in font:
    raise Exception("Font does not have fvar table")

var = font["gvar"].variations
for glyphname, value in var.items():
    glyph = font["glyf"][glyphname]
    numPointsInGlyph = font["gvar"].getNumPoints_(glyph)

    minusValue = TupleVariation(
        {"TRAK": (-1.0, -1.0, 0.0)}, [(0, 0)] * numPointsInGlyph
    )
    minusValue.coordinates[-3] = (-font["head"].unitsPerEm, 0)

    plusValue = TupleVariation({"TRAK": (0.0, 1.0, 1.0)}, [(0, 0)] * numPointsInGlyph)
    plusValue.coordinates[-3] = (font["head"].unitsPerEm, 0)

    value.append(minusValue)
    value.append(plusValue)

# HVAR is horrible and I hate it.
if "HVAR" in font:
    del font["HVAR"]

# Add axis at the end after gvar is decompiled
trak = Axis()
trak.axisTag = "TRAK"
trak.minValue, trak.defaultValue, trak.maxValue = -1000, 0, 1000
trak.axisNameID = font["name"].addName("Tracking")
fvar = font["fvar"]
fvar.axes.append(trak)

# Each named instance needs to add the axis too, even though we're not using it there.
for instance in fvar.instances:
    instance.coordinates["TRAK"] = 0

font.save(args.output)