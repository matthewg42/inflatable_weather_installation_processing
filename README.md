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


