To Install:

	While in desired mode (assembly/part/drawing) right click Command Bar and Select Customize...
	On the Commands tab, select Macro. Drag the button with a man/play symbol to the desired button location.
	Customize Image, Tooltip, and Hover Prompt. In Macro category, browse to desired .swp file.
	Customize keyboard shortcut.
	Shortcut may then be added to any shortcut bar or context menu.



To Use:

FileOpen.swp - Used to open a file without having to browse to it in an explorer window. Use in part, assembly, drawing, or when no file is opened.
	Clicking on the FileOpen button or using the keyboard shortcut will open a prompt. Type part number to open the part.
	Part must be in correct -SCOTT or S-ARCHITECTURAL folder location with matching name.
	With no extension entered, the macro will open an assembly if it exists or a part file if no assembly exists.
	To open a drawing, add ".slddrw" or ".drawing" or ".d" to the end of the part number.
	To open an assembly, add ".sldasm" or ".assembly" or ".a" to the end of the part number.
	To open a part, add ".sldprt" or ".part" or ".p" to the end of the part number.
	To open a flat pattern, add ".flat" or ".f" to the end of the part number.
	To open an explode drawing, add ".explode" or ".exp" or ".e" to the end of the part number.
	To open a label drawing, add ".label" or ".l" to the end of the part number.
	To open an instruction, add ".instruction" or ".ins" or ".i" to the end of the part number.


FileRef.swp - Used to reassociate a missing part or subassembly in an assembly. Use in assembly.
	In assembly mode, click on the missing parts or subassemblies in the feature manager.
	Click the FileRef button or use the keyboard shortcut.
	The macro will find the parts with names matching the selected parts in their -SCOTT folder locations.
	Parts must be in correct -SCOTT folder locations with matching name.
	Selecting a resolved part will prompt the user if they want to update the reference.
	Selecting "Yes" will update the reference to the part in the correct -SCOTT folder location if it exists.


pdfPacket.swp - Used to create a pdf packet using pdfFactory. Use in assembly.
	In drawing mode, the button will simply print the drawing to pdfFactory.
	In assembly mode, click on the parts or subassemblies with drawings to be put into pdf packet.
	Click the pdfPacket button or use the keyboard shortcut to create the pdfPacket.
	Do not close or interrupt the packeting process.
	For an assembly titled "PRODUCT", the macro will first add "PRODUCT.SLDDRW" to the packet.
	Then, it will search for and add "PRODUCT EXP.SLDDRW" to the packet if it exists.
	Likewise, it will search for and add "PRODUCT LABEL.SLDDRW" to the packet if it exists.
	It will then add "PRODUCT INS.SLDDRW" to the packet if it exists.
	Also, it will add "PRODUCT AUX.SLDDRW" to the packet if it exists.
	Finally, the macro will search for drawings for the selected parts or subassemblies and add the drawings to the packet in the order in which they
	were selected.
	All drawing files will be printed using the scale settings already set in the drawing files themselves.

FileInsert.swp - Used to quickly insert a part in an assembly at the origin. Use in assembly.
	Clicking on the FileOpen button or using the keyboard shortcut will open a prompt. Type part number to inser the part.
	Part must be in correct -SCOTT or S-ARCHITECTURAL folder location with matching name.
	With no extension entered, the macro will open an assembly if it exists or a part file if no assembly exists.
	To open an assembly, add ".sldasm" or ".assembly" or ".a" to the end of the part number.
	To open a part, add ".sldprt" or ".part" or ".p" to the end of the part number.

ContextOpen_.swp - Multiple (L;F;I;E). Used to quickly open an explode drawing, label drawing, instruction, or flat pattern for the active assembly. Use in assembly.
	Intended to be installed as a context menu option. Clicking on the corresponding ContextOpen_ button will instantly open the explode, label,
	instruction or flat associated with the active assembly. A separate ContextOpen_ macro is available for each drawing type.
	ContextOpenFlat may also be used in part mode.