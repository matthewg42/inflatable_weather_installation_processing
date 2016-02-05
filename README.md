## Install Dependencies

json_simple should be installed:

*   Download from https://code.google.com/archive/p/json-simple/ (only the jar file is required)
*   Create $SKETCHBOOK/libraries/json_simple/library directory (where $SKETCHBOOK can be found in processing prefs)
*   Copy json_simple-x.x.x.jar to this folder
*   Rename json_simple-x.x.x.jar to json_simple.jar

## Porting from Processing 2 to Processing 3

See https://github.com/processing/processing/wiki/Changes-in-3.0

Problems found / corrected:

*   PApplet is no longer a java.awt.Applet.  Some re-writing will be required to take account of this

## Other fixes / changes

### Build error: "JSONObject is ambigious"

## Patterns in current Arduino code:

1 = Large Decibel
2 = Small Decibel
3 = CO2
R = Rest

    0   1   2   3   4   5   6   7   8
A   3   3   R   R   R   R
B   1   1   1   1
C   1   1   1   1
D   3   3   3   3   R   R   R   R
E   13  13  13  13  1   1   1   1
F   123 123 123 123 12  12  12  12
G   3   3   R   R
H   13  13  1   1
I   123 123 12  12
J   3   R   3   3   R   R   R   R
K   13  1   3   3   R   R   R   R
L   123 12  3   R   R   R   R   R


