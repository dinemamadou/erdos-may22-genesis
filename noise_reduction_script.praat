	# This praat script removes any noise that is equivalent to the noise within the first 50ms of each audio

	dir$ = "/Users/.../Desktop/Erdos-Institute_Bootcamp2022/erdos-may22-genesis/Data/Test/"
	denoised$ = "/Users/.../Desktop/Erdos-Institute_Bootcamp2022/erdos-may22-genesis/Data/Test_denoised/"

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