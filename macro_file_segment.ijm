nuc = 0;
fluo_green = 1;
fluo_red = 2; 

run("Bio-Formats Macro Extensions");
currentDirectory = getDirectory("Choose a directory");

fileList = getFileList(currentDirectory);

for (file = 0; file < fileList.length; file++) {
		
	Ext.isThisType(currentDirectory + fileList[file], supportedFileFormat);
	if (supportedFileFormat=="true") {
		label = substring(fileList[file],0,lengthOf(fileList[file])-4);
		Ext.setId(currentDirectory + fileList[file]);
		Ext.getSeriesCount(seriesCount);


	for (j = 0; j < seriesCount; j++){
		run("Close All");
		Ext.setSeries(j);
		Ext.getSeriesName(seriesName);
		Ext.getImageCount(ImageCount);
		if (!startsWith(seriesName, "10x") || ImageCount != 3){
			continue;
		}
		run("Bio-Formats Importer", "open=["+currentDirectory + fileList[file]+"] autoscale color_mode=Default split_channels view=[Standard ImageJ] stack_order=Default series_"+(j+1));
		name = getTitle();
		print(name);
		
		prefix = substring (name, 0, lastIndexOf(name," "));
		//print(prefix);
	
	green_name = prefix+" C="+d2s(fluo_green, 0);
	nuc_name = prefix+" C="+d2s(nuc, 0);
	red_name = prefix+" C="+d2s(fluo_red, 0);
	
	selectWindow(green_name);
	rename("pErk");	
	
	selectWindow(red_name);
	rename("mRuby3");
	
	selectWindow(nuc_name);
	rename("Hoechst");
	
	
	run("Merge Channels...", "c1=mRuby3 c2=pErk c3=Hoechst create keep");
	saveAs("tif", currentDirectory+"processed\\"+label+"_"+String.pad(j,4)+".tif");
	close();
	
	
	//selectWindow("pErk");
	//saveAs("tif", output+"pERK\\"+label+String.pad(j,2)+".tif");
	//close();
	
	//selectWindow("AAV");
	//saveAs("tif", output+"AAV\\"+label+String.pad(j,2)+".tif");
	//close();
	
	//selectWindow("Hoechst");
	//saveAs("tif", output+"Hoechst\\"+label+String.pad(j,2)+".tif");
	//close();

		
		}
	}
	else{
		continue;
	}
}
