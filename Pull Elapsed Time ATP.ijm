print("\\Clear");

run("Bio-Formats Macro Extensions");
id = File.openDialog("Choose a file");
//print("Image path: " + id);
Ext.setId(id);
Ext.openImagePlus(id)

title = getInfo("image.filename");
title = substring(title, 0, lengthOf(title) -3); //remove .nd extension


//creationDate = "";
//Ext.getImageCreationDate(creationDate);
//print("Creation date: " + creationDate);

//Ext.getDimensionOrder(dimOrder);
//print("Dimension order: ",dimOrder);

Ext.getImageCount(imageCount);
//print("Plane count: " + imageCount);
//creationDate = "";

/*
Ext.getSeriesCount(seriesCount);
for (s=0; s<seriesCount; s++) {
Ext.setSeries(s);
Ext.getSizeX(sizeX);
Ext.getSizeY(sizeY);
Ext.getSizeZ(sizeZ);
Ext.getSizeC(sizeC);
Ext.getSizeT(sizeT);
print("Series #" + s + ": image resolution is " + sizeX + " x " + sizeY);
print("Focal plane count = " + sizeZ);
print("Channel count = " + sizeC);
print("Time point count = " + sizeT);
}
*/


deltaT = newArray(imageCount);
//exposureTime = newArray(imageCount);
print("Plane deltas (seconds since experiment began):");
for (no=0; no<imageCount; no++) {

Ext.getPlaneTimingDeltaT(deltaT[no], no);
//Ext.getPlaneTimingExposureTime(exposureTime[no], no);

if (deltaT[no] == deltaT[no]) { // not NaN
//s = "\t" + (no + 1) + ": " + deltaT[no] + " s";
s = deltaT[no];

//if (exposureTime[no] == exposureTime[no]) { // not NaN
//s = s + " [exposed for " + exposureTime[no] + " s]";
//}

print(s);
}
}
selectWindow("Log")
saveAs("Text", "/Users/wsalmon/Google Drive/Thesis/Analysis/Calcium dynamics/Raw Measurements 2017/ATP 2017 analysis et files/"+title+" et.txt");
close();
//print("Complete.");
