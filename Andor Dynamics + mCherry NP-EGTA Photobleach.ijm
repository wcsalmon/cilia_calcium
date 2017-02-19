roiManager("reset");
print("\\Clear");
run("Set Measurements...", "area mean standard min centroid integrated stack nan redirect=None decimal=2");


//measure mCherry signal and GECO signal from starting image
waitForUser("Open .nd file and activate threshold function");
title = getInfo("image.filename");
title = substring(title, 0, lengthOf(title) -3); //remove .nd extension

print(title);
Stack.setChannel(2);
resetMinAndMax();


//define cilium by thresholding mCherry signal and manually using the magic wand tool
setThreshold(200, 4095);
waitForUser("Modify Threshold values if apporpriate.  Use magic wand to outline cilium")
//waitForUser("Use magic wand to outline cilium");
getThreshold(lower, upper);
roiManager("Add");
waitForUser("move region to background");
roiManager("Add");
roiManager("Show None");

//save regions, mCherry measurements and threshold values
roiManager("Save", "/Users/wsalmon/Google Drive/Thesis/Analysis/Calcium dynamics/Raw Measurements 2017 - region/NP-EGTA 2017 Photobleaching/"+title+".zip");
roiManager("Multi Measure");
saveAs("Results", "/Users/wsalmon/Google Drive/Thesis/Analysis/Calcium dynamics/Raw Measurements 2017 - region/NP-EGTA 2017 Photobleaching/"+title+"mCh.csv");
print("Threshold min ", lower);
print("Threshold max ", upper);


//NP-EGTA set up to measure GECO dynamics
waitForUser("Open time series file");
title = getInfo("image.filename");
title = substring(title, 0, lengthOf(title) -4); //remove .tif extension
print(title);

//SliceRemover to truncate files collected with repeated activations
//run("Slice Remover", "first=101 last=600 increment=1");

//load regions and measure for all planes
roiManager("Show All");
waitForUser("Confirm the sample doesn't move out of the region");
roiManager("Show All");
roiManager("Save", "/Users/wsalmon/Google Drive/Thesis/Analysis/Calcium dynamics/Raw Measurements 2017 - region/NP-EGTA 2017 Photobleaching/"+title+"GECO.zip");
roiManager("Multi Measure");
saveAs("Results", "/Users/wsalmon/Google Drive/Thesis/Analysis/Calcium dynamics/Raw Measurements 2017 - region/NP-EGTA 2017 Photobleaching/"+title+".xls");
selectWindow("Log")
saveAs("Text", "/Users/wsalmon/Google Drive/Thesis/Analysis/Calcium dynamics/Raw Measurements 2017 - region/NP-EGTA 2017 Photobleaching/"+title+"_log.txt");
close();
close();