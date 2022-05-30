	# This praat script removed any noise that is beyond 9000Hz
	# /Users/tadjou-ndinemamadouyacoubou/Desktop/Erdos-Institute_Bootcamp2022/erdos-may22-genesis/Data/Train/

	dir$ = "/Users/tadjou-ndinemamadouyacoubou/Desktop/Erdos-Institute_Bootcamp2022/erdos-may22-genesis/Data/Test/"
	denoised$ = "/Users/tadjou-ndinemamadouyacoubou/Desktop/Erdos-Institute_Bootcamp2022/erdos-may22-genesis/Data/Test_denoised/"

	Create Strings as file list: "files" , dir$ + "*.wav"
	nFiles = Get number of strings
	
	for i from 1 to nFiles
		selectObject: "Strings files"
		filename$ = Get string: i
		basename$ = filename$ - ".wav"
		Read from file: dir$ + basename$ + ".wav"
		Reduce noise: 0.0, 0.05, 0.025, 80.0, 10000.0, 40.0, -20.0, "spectral-subtraction"
		Save as WAV file: denoised$ + basename$ + ".wav"
		Remove
	endfor