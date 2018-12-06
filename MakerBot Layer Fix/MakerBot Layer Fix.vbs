'MakerBot Layer Fix
'Modify MakerBot json file to allow resuming a partially finished 3D print from a known layer
'
'To use:
'Export the MakerBot project to a .makerbot file
'Change the extension of the .makerbot file to .zip
'Open the .zip and copy the print.jsontoolpath file and meta.json file to outside the .zip
'Place this script and the FIRSTLAYER.txt file in the same folder
'Determine the layer at which the print stopped
'Execute the script
'The script will create a new print.jsontoolpath file in a folder called "fix"
'The script will also copy the meta.json file into the "fix" folder
'Compress the two files into a .zip and give it a name
'Change the extension of the .zip back to .makerbot
'Print from the .makerbot file

t = timer
Set objShell = CreateObject("Wscript.Shell")
strPath = objShell.CurrentDirectory + "\"

StartLayerData = ""
startLayer = "0"
startLayerHeight = 0
starta = "0.0"
startx = "0.0"
starty = "0.0"
startz = "0.0"
startLP = "0.0"
startUP = "0.0"
newa = "-1.10"
newLayer = 1
data = 0

strLine = ""
userIn = ""
userIn = InputBox("Enter start layer or height in mm: " + vbCrLf + "Example: ""layer 745"", ""745"", ""175mm"".")
If InStr(userIn, "mm") Then
	startLayerHeight = split(userIn, "mm", 1)(0)
	data = 1
ElseIf InStr(userIn, "layer", 1) Then
	startLayer = split(userIn, "layer", 1)(1)
	data = 0
Else
	startLayer = userIn
	data = 0
End If

strFolder = strPath + "fix\"
strFileName = "print.jsontoolpath"
strMetaFile = "meta.json"
strFirstLayerFile = "FIRSTLAYER.txt"

Set objFolder = CreateObject("Scripting.FileSystemObject")
If Not objFolder.FolderExists(strFolder) Then objFolder.CreateFolder strFolder End If
objFolder.CopyFile strMetaFile, strFolder, True
Set objFS = CreateObject("Scripting.FileSystemObject")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFirstLayer = CreateObject("Scripting.FileSystemObject")
strFile = strPath + strFileName
Set objFile = objFS.OpenTextFile(strFile, 1)
Set objFileNew = objFSO.OpenTextFile(strFolder + strFileName, 2, True)
Set objFirstLayerFile = objFirstLayer.OpenTextFile(strPath + strFirstLayerFile, 1)

FirstLayerData = objFirstLayerFile.ReadAll


'Record values from start layer; create new start layer
Do Until InStr(strLine, "Layer Section " + startLayer)
	strLine = objFile.ReadLine
Loop
tempstr = split(strLine, "Layer Section ")(1)
StartLayerData = StartLayerData + left(strLine, InStr(strLine, "Layer Section ")+len("Layer Section ")-1) + Cstr(newLayer) + right(strLine, len(strLine)-InStr(strLine, "(")+2) + vbCrLf
Do Until InStr(strLine, "Lower Position")
	strLine = objFile.ReadLine
	StartLayerData = StartLayerData + strLine + vbCrLf
Loop
tempstr = split(strLine, "Lower Position ")(1)
startLP = left(tempstr, InStr(tempstr, """")-1)
Do Until InStr(strLine, "Width")
	strLine = objFile.ReadLine
	StartLayerData = StartLayerData + strLine + vbCrLf
Loop
strLine = objFile.ReadLine
Do Until InStr(strLine, "move")
	StartLayerData = StartLayerData + strLine + vbCrLf
	strLine = objFile.ReadLine
Loop
StartLayerData = StartLayerData + left(strLine, 115) + CStr(newa) + right(strLine, len(strLine)-InStr(strLine, "feedrate")+3)
starta = split(split(strLine, """a"":")(2), ",")(0)+1.1
startx = split(split(strLine, """x"":")(2), ",")(0)
starty = split(split(strLine, """y"":")(2), ",")(0)
startz = split(split(strLine, """z"":")(2), "},")(0)

'Fix first layer with initial values
FirstLayerData = Replace(FirstLayerData, "VARlayer", "0")
FirstLayerData = Replace(FirstLayerData, "VARlowerPosition", "-0.2")
FirstLayerData = Replace(FirstLayerData, "VARupperPosition", startLP)
FirstLayerData = Replace(FirstLayerData, "VARthickness", CDbl(startLP) + .2)
FirstLayerData = Replace(FirstLayerData, "VARa", "-1.10")
FirstLayerData = Replace(FirstLayerData, "VARx", startx)
FirstLayerData = Replace(FirstLayerData, "VARy", starty)
FirstLayerData = Replace(FirstLayerData, "VARz", startz)

objFileNew.WriteLine FirstLayerData
objFileNew.WriteLine StartLayerData

'Fix remaining layers
'Do Until InStr(strLine, "Layer Section 102")
Do Until objFile.AtEndOfStream
	strLine = objFile.ReadLine
	If InStr(strLine, """a"":") Then
		newa = CDbl(split(split(strLine, """a"":")(2), ",")(0)) - CDbl(starta)
		If newa = 0 Then newa = "0.0"
		objFileNew.WriteLine left(strLine, 115) + FormatNumber(newa,13,-1,0,0) + right(strLine, len(strLine)-InStr(strLine, "feedrate")+3)
	ElseIf InStr(strLine, "Layer Section ") Then
		newLayer = newLayer + 1
		objFileNew.WriteLine left(strLine, InStr(strLine, "Layer Section ")+len("Layer Section ")-1) + CStr(newLayer) + right(strLine, len(strLine)-InStr(strLine, "(")+2)
	Else
		objFileNew.WriteLine strLine
	End If
Loop

objFile.Close
objFileNew.Close
objFirstLayerFile.Close
Wscript.Echo "Done in " + Cstr(timer-t) + " s."