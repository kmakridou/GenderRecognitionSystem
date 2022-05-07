clear all;
close all;
%ta packages pou xrisimopoihsame gia tin ergasia

%    pkg install -forge specfun
%    pkg install -forge control
%    pkg install -forge general

%    pkg install -forge signal
%    pkg install -forge communications 

%% fortwnw ta packages 
pkg load signal; 
pkg load communications; 


%% Dimiourgia tou arxikou menu
disp ('Hello! Welcome to Voice Gender Recognition system.');
disp('Please enter a number between 1-3 ');%odigies ston xristi
disp('For audio recording, press 1');
disp('For audio load, press 2');
disp('For exit press 3');
prompt = input ('Enter your preference (1,2,3): ', 's');

%dimiourgia tou audio recording
if strcmpi (prompt, '1')
    fs = 8000;
    nbits = 16;
    nchannels = 1;
    dev = audiodevinfo;%pairnw ta stoixeia tis syskevis
    recording = audiorecorder(fs, nbits, nchannels);%dimiourgw to ixografimeno arxeio(sixnotita, bits)
    disp('Start Recording');%emfanizetai to minima Start Recording
    recordblocking(recording, 3);%ixografw 3 deuterolepta
    disp('Finished Recording');%emfanizw to minima stop recording
    y = getaudiodata(recording);%pairnw ta stoixeia tou ixografimenou arxeiou
    plot(y);%emfanizw ena sxima pou anaparista to ixografimeno arxeio
    audiowrite('C:/gender/Recorded.wav', y, fs);
	
	% anaparagwgi tis ixografisis
	  disp('Listen to your recorded voice sample');%mefanizei to minima Listen to your recorded voice sample
    [y, fs] = audioread('Recorded.wav');%fortwnetai to ixografimeno arxeio
    soundsc(y, fs);%anaparagwgi tou arxeiou Recorded.wav
    
	disp('Plotting the waveform');%emfanizei to minima gia tin optikopoiissi

	%thetw to y iso me tis parametrous tou recording
  %gia na mporw na to optikopoihsw
	y = getaudiodata(recording);

	%optikopoiisi
	figure 1, plot(y);
	
  %------apo edw kai katw o kwdikas einai apo tis piges-------------------------------------------------------
	ms2 = fs/500;%elaxisti omilia fx sta 500 hz
	ms20 = fs/50;%-"- sta 50 hz

	r = xcorr(y, ms20, 'coeff');%metra ti sisxetisi tou deigmatos y (autocorrelation)
	d = (-ms20:ms20)/fs;%metra ton xrono kathisterisi se sec

	figure 2,plot(d,r); %anaparastasi se sxima
	title('Autocorrelation');%titloi
	xlabel('Delay (s)');%titlos x
	ylabel('Correlation coeff.');%titlos y

  %vriskei tis thetikes kathisteriseis
	r = r(ms20+1:2*ms20+1);
	[rmax, tx] = max(r(ms2:ms20));
	Fx = fs/(ms2+tx-1);%i sixnotita tis fwnis tou deigmatos
  %--------mexri edw------------------------------------------------------------------------------------------


	Fth = 160;%to orio pou prosdiorizei tin andriki kai gynaikeia fwni (andriki:85-155 gynaikeia:165-255)

	if Fx>Fth%an to Fx tis ixografisis > tou oriou tote
		disp("\n\nIt is a female voice!\n\n")%gnaikeia fwni
    [y, fs] = audioread('Female.wav');%paizei to ixitiko arxeio female voice
    soundsc(y, fs)
	else
		disp("\n\nIt is a male voice\n\n")%andriki
    [y, fs] = audioread('Male.wav');%paizei to ixitiko arxeio male voice
    soundsc(y, fs)
	end 

	fprintf("\n\nPress any key to close program!\n\n"); %emfanizw auto to minima
  pause();%pausi mexri na patithei kapoio koumpi

%% fortwma arxeiou
elseif strcmpi (prompt, '2')
	%o xristsis prepei na eisagei to path pou exei topothetisei to arxeio
	file_path = input("please enter the audio file path: (full path name + .wav)\n\n","s");
	[y,fs] = audioread(file_path);
	% anaparagwgi tou arxeiou
	sound(y,fs);
	%optikopoiisi tou deigmatos
        figure 1, plot(y);
%-------------------idia pigi me pio panw------------------------------------------------------------------------------------------------------------------------------
	      ms2 = fs/500;
        ms20 = fs/50;

        r = xcorr(y, ms20, 'coeff');
        d = (-ms20:ms20)/fs;

        figure 2,plot(d,r);
        title('Autocorrelation');
        xlabel('Delay (s)');
        ylabel('Correlation coeff.');

        r = r(ms20+1:2*ms20+1);
        [rmax, tx] = max(r(ms2:ms20));
        Fx = fs/(ms2+tx-1);
%-------------------------------------------------------------------------------------------------------------------------------------------------
        %to orio
        Fth = 160;

        if Fx>Fth %an to Fx tou arxeiou>orio tote
          disp("\n\nIt is a female voice!\n\n")%gnaikeia fwni
          [y, fs] = audioread('Female.wav');%paizei to ixitiko arxeio female voice
          soundsc(y, fs)
        else
           disp("\n\nIt is a male voice!\n\n")%gnaikeia fwni
          [y, fs] = audioread('Male.wav');%paizei to ixitiko arxeio female voice
          soundsc(y, fs)
        end

	fprintf("\n\nPress any key to close program!\n\n"); %emfanizw to minima ayto
  pause();%pausi mexri na patithei kapoio koumpi.

%% eksodos apo to programma
elseif strcmpi (prompt, '3')%an o xristis patisei 3
	disp('Exiting...');%minima stin othoni
	exit();%eksodos

%akuri epilogi
else 
	disp('Invalid Input');
endif