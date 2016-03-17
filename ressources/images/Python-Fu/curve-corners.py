from gimpfu import *

    def plugin_func(timg, tdrawable,percentage):
    #pdb.gimp_selection_all(image)
    #pdb.script_fu_selection_rounded_rectangle(image, drawable, percentage, false)
    register(
    "curve-corners",
    "Curves the corners of a rectangular image",
    "Increasing the radius parameter makes the corners bigger.",
    "Baptiste Canovas-Virly",
    "LGPL licence",
    "2016",
    "<Image>/BroPosey/Curve the corners captain !",
    "*",
    [
    (PF_IMAGE, "timg", "Input image", None),
    (PF_DRAWABLE, "tdrawable", "Input drawable", None),
    (PF_STRING, "radius", "Radius of the corners", 5)
    ],
    [],
    plugin_func, menu="<Image>/BroPosey/Curve the corners goddammit !")
main()