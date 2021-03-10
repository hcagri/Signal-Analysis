classdef project_2231470_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        SoundRecorderTab                matlab.ui.container.Tab
        SoundRecorderLabel              matlab.ui.control.Label
        FsEditFieldLabel                matlab.ui.control.Label
        FsEditField                     matlab.ui.control.NumericEditField
        StartButton                     matlab.ui.control.Button
        StopButton                      matlab.ui.control.Button
        PlayandPlotButton               matlab.ui.control.Button
        WindowSizeEditFieldLabel        matlab.ui.control.Label
        WSizeRecord                     matlab.ui.control.NumericEditField
        WindowShiftEditFieldLabel       matlab.ui.control.Label
        WShiftRecord                    matlab.ui.control.NumericEditField
        WindowTypeDropDown_2Label       matlab.ui.control.Label
        WindowTypeRecord                matlab.ui.control.DropDown
        CosineFractionEditFieldLabel    matlab.ui.control.Label
        CosineFractionRecord            matlab.ui.control.NumericEditField
        BetaEditFieldLabel              matlab.ui.control.Label
        BetaRecord                      matlab.ui.control.NumericEditField
        WindowParametersLabel           matlab.ui.control.Label
        PickaSoundTab                   matlab.ui.container.Tab
        PickaSoundLabel                 matlab.ui.control.Label
        FileEditFieldLabel              matlab.ui.control.Label
        FileEditField                   matlab.ui.control.EditField
        BrowseButton                    matlab.ui.control.Button
        PlayandPlotButton_2             matlab.ui.control.Button
        WindowSizeEditFieldLabel_2      matlab.ui.control.Label
        WSizePick                       matlab.ui.control.NumericEditField
        WindowShiftEditFieldLabel_2     matlab.ui.control.Label
        WShiftPick                      matlab.ui.control.NumericEditField
        CosineFractionEditField_2Label  matlab.ui.control.Label
        CosineFractionPick              matlab.ui.control.NumericEditField
        WindowTypeDropDown_2Label_2     matlab.ui.control.Label
        WindowTypePick                  matlab.ui.control.DropDown
        BetaEditField_2Label            matlab.ui.control.Label
        BetaPick                        matlab.ui.control.NumericEditField
        WindowParametersLabel_2         matlab.ui.control.Label
        GenerateSignalTab               matlab.ui.container.Tab
        SignalTypeDropDownLabel         matlab.ui.control.Label
        SignalTypeDropDown              matlab.ui.control.DropDown
        GenerateaSignalLabel            matlab.ui.control.Label
        SamplingFrequencyEditFieldLabel  matlab.ui.control.Label
        SamplingFrequencyEditField      matlab.ui.control.NumericEditField
        TotalLengthsecEditFieldLabel    matlab.ui.control.Label
        TotalLengthsecEditField         matlab.ui.control.NumericEditField
        GenerateButton                  matlab.ui.control.Button
        AmplitudeEditFieldLabel         matlab.ui.control.Label
        AmplitudeEditField              matlab.ui.control.NumericEditField
        FrequencyEditFieldLabel         matlab.ui.control.Label
        FrequencyEditField              matlab.ui.control.NumericEditField
        PhaseEditFieldLabel             matlab.ui.control.Label
        PhaseEditField                  matlab.ui.control.NumericEditField
        DutyCycleEditFieldLabel         matlab.ui.control.Label
        DutyCycleEditField              matlab.ui.control.NumericEditField
        WidthEditFieldLabel             matlab.ui.control.Label
        WidthEditField                  matlab.ui.control.NumericEditField
        AddButton                       matlab.ui.control.Button
        LabelPlease                     matlab.ui.control.Label
        AppendButton                    matlab.ui.control.Button
        GenerateAppendButton            matlab.ui.control.Button
        WindowSizeEditFieldLabel_3      matlab.ui.control.Label
        WSizeGen                        matlab.ui.control.NumericEditField
        WindowShiftEditFieldLabel_3     matlab.ui.control.Label
        WShiftGen                       matlab.ui.control.NumericEditField
        CosineFractionEditFieldLabel_2  matlab.ui.control.Label
        CosineFractionGen               matlab.ui.control.NumericEditField
        BetaEditFieldLabel_2            matlab.ui.control.Label
        BetaGen                         matlab.ui.control.NumericEditField
        WindowTypeDropDown_2Label_3     matlab.ui.control.Label
        WindowTypeGen                   matlab.ui.control.DropDown
        InitialFrequencyEditFieldLabel  matlab.ui.control.Label
        InitialFrequencyEditField       matlab.ui.control.NumericEditField
        FinalFrequencyEditFieldLabel    matlab.ui.control.Label
        FinalFrequencyEditField         matlab.ui.control.NumericEditField
        ClearAppendButton               matlab.ui.control.Button
        TocreateconcatenatedsignalswithdifferenttypesuseappendtoolLabel  matlab.ui.control.Label
        TabGroup2                       matlab.ui.container.TabGroup
        TimeDomainTab                   matlab.ui.container.Tab
        UITime                          matlab.ui.control.UIAxes
        FrequencyDomainTab              matlab.ui.container.Tab
        UIFrequency                     matlab.ui.control.UIAxes
        SpectogramTab                   matlab.ui.container.Tab
        UISpec                          matlab.ui.control.UIAxes
    end

    
    methods (Access = private)
        
        function [t, result] = sinusoidal_signal(app)
            Fs = app.SamplingFrequencyEditField.Value;
            Length = app.TotalLengthsecEditField.Value;
            Ac = app.AmplitudeEditField.Value;
            f = app.FrequencyEditField.Value;
            phase = app.PhaseEditField.Value;   
            
            t = linspace(0,Length, Length*Fs);
            result = Ac*sin(2*pi*f*t + phase);
        end
        
        function [t,result] = square_wave(app)
            Fs = app.SamplingFrequencyEditField.Value;
            Length = app.TotalLengthsecEditField.Value;
            Ac = app.AmplitudeEditField.Value;
            f = app.FrequencyEditField.Value;
            phase = app.PhaseEditField.Value;
            duty = app.DutyCycleEditField.Value;
            
            t = linspace(0,Length, Length*Fs);
            result = Ac*square(2*pi*f*t + phase, duty);
            
        end
        
        function f_plot(app, signal, Fs)
            
          len = length(signal);  
          w_axis = (-Fs/2:Fs/(len-1):Fs/2)/1e3;
          Sf = fftshift(abs(fft(signal, len)))/Fs;
          plot(app.UIFrequency,w_axis, Sf);

            
        end
        
        function [t,result] = sawtooth_wave(app)
            Fs = app.SamplingFrequencyEditField.Value;
            Length = app.TotalLengthsecEditField.Value;
            Ac = app.AmplitudeEditField.Value;
            f = app.FrequencyEditField.Value;
            phase = app.PhaseEditField.Value;
            width = app.WidthEditField.Value;
            
            t = linspace(0,Length, Length*Fs);
            result = Ac*sawtooth(2*pi*f*t + phase, width);
            
            
        end
        
        function myspectrogram(app, signal, Fs, M, H, win_type, beta, r)
            
            % This function calculates STFT of a given signal and than
            % plots the spectrogram of that function.
            Y = signal;
            len = length(Y);
            duration = len/Fs;

            % make sure that we have a column vector
            [row, column] = size(Y);
            if column > row
                Y = Y';
            end
            
            
            if strcmp(win_type, 'Hamming')
                Wn = hamming(M);    
            elseif strcmp(win_type, 'Rectangle')
                Wn = ones(M,1);
            elseif strcmp(win_type, 'Hanning')
                Wn = hanning(M);    
            elseif strcmp(win_type, 'Kaiser')
                Wn = kaiser(M, beta);
            elseif strcmp(win_type, 'Blackman')
                Wn = blackman(M);
            elseif strcmp(win_type, 'Gaussian')
                Wn = gausswin(M);
            elseif strcmp(win_type, 'Tukey')
                Wn = tukeywin(M, r);
            end
            
            
            
            num_iteration = length(Y)/H;
            
            spec_matrix = []; % Each cloumns is a DFT vector for different partition.
            
            for k = 1:num_iteration - 1
               
                if H*(k-1 )+ M > len
                    partition = Y( (k-1)*H:end,1);
                    if strcmp(win_type, 'Hamming')
                        Wn = hamming(length(partition));    
                    elseif strcmp(win_type, 'Rectangle')
                        Wn = ones(length(partition),1);
                    elseif strcmp(win_type, 'Hanning')
                        Wn = hanning(length(partition));    
                    elseif strcmp(win_type, 'Kaiser')
                        Wn = kaiser(length(partition), beta);
                    elseif strcmp(win_type, 'Blackman')
                        Wn = blackman(length(partition));
                    elseif strcmp(win_type, 'Gaussian')
                        Wn = gausswin(length(partition));
                    elseif strcmp(win_type, 'Tukey')
                        Wn = tukeywin(length(partition), r);
                    end
                else
                    partition = Y( (k-1)*H +(1:M) ,1);
                end
                F = fft(partition .* Wn, M); % M point fft
                
                % Since we deal with real signals 
                % We can use the symmetry property of DFT by taking only the first half
                
                Half_F = F(1:ceil(M/2));
                
                spec_matrix = [spec_matrix, Half_F]; % stack each DFT column side by side
                
            end
            
            [r, c] = size(spec_matrix); 
            
            % Since the highest frequency in DFT (pi) corresponds to Fs/2 arrange the
            % frequency values according to that. in kHz
            f = ((Fs/(2*r))/1000).*(1:r);
            
            % normalize t values to seconds
            
            t = (duration/(c-1)).*(0:c-1);
            
            surf(app.UISpec,t, f, 10*log(abs(spec_matrix)), 'EdgeColor', 'none');
            axis(app.UISpec, 'tight');
            colorbar(app.UISpec, "east");
            colormap(app.UISpec, 'parula' );
            app.UISpec.View = [0, 90];
                 
            
        end
        
        function [t,results] = mychirp(app)
            Fs = app.SamplingFrequencyEditField.Value;
            Length = app.TotalLengthsecEditField.Value;
            Ac = app.AmplitudeEditField.Value;
            f0 = app.InitialFrequencyEditField.Value;
            f1 = app.FinalFrequencyEditField.Value;
            phase = app.PhaseEditField.Value;   
            
            t = linspace(0,Length, Length*Fs);
            results = Ac*chirp(t,f0,t(end),f1,'li',phase);
            
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            app.AmplitudeEditField.Visible = 'on';
            app.FrequencyEditField.Visible = 'on';
            app.PhaseEditField.Visible = 'on';
            app.DutyCycleEditField.Visible = 'off';
            app.DutyCycleEditFieldLabel.Visible = 'off';
            app.WidthEditField.Visible = 'off';
            app.WidthEditFieldLabel.Visible = 'off';
            app.AddButton.Visible = 'off';
            app.LabelPlease.Visible = 'off';
            app.CosineFractionPick.Visible = 'off';
            app.BetaPick.Visible = 'off';
            app.CosineFractionRecord.Visible = 'off';
            app.BetaRecord.Visible = 'off';
            app.CosineFractionGen.Visible = 'off';
            app.BetaGen.Visible = 'off';
            app.InitialFrequencyEditField.Visible = 'off';
            app.InitialFrequencyEditFieldLabel.Visible = 'off';
            app.FinalFrequencyEditField.Visible = 'off';
            app.FinalFrequencyEditFieldLabel.Visible = 'off';
            app.CosineFractionEditFieldLabel.Visible = 'Off';
            app.BetaEditFieldLabel.Visible = 'off';
            app.CosineFractionEditFieldLabel_2.Visible = 'off';
            app.BetaEditFieldLabel_2.Visible = 'off';
            app.CosineFractionEditField_2Label.Visible = 'off';
            app.BetaEditField_2Label.Visible = 'off';
            
            app.WShiftGen.Value = 256;
            app.WSizeGen.Value = 256;
            app.WShiftPick.Value = 256;
            app.WSizePick.Value = 256;
            app.WShiftRecord.Value = 256;
            app.WSizeRecord.Value = 256;
            
            
            grid(app.UITime, 'on');
            grid(app.UIFrequency, 'on');
            app.UITime.XLabel.String = 'Time in seconds';
            app.UITime.YLabel.String = 'Amplitude';
            app.UIFrequency.XLabel.String = 'Frequency in kHz';
            app.UIFrequency.YLabel.String = 'Amplitude in dB scale';
            
            app.UISpec.XLabel.String = 'Time (sec)';
            app.UISpec.YLabel.String = 'Frequency (kHz)';
            
            
            % for sum of sinusoids
            sum_sinusoids = [];
            assignin("base","sum_sinusoids",sum_sinusoids); 
            
            appended_signals = [];
            assignin("base","appended_signals",appended_signals); 
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            Fs = app.FsEditField.Value;
            if Fs < 1000000 && Fs > 80
                audioObj = audiorecorder(Fs,16,1);
                msgbox("Recording has started");
                record(audioObj);
                assignin("base","audioObj",audioObj);      
            else
                msgbox("Please Provide a valid Sampling Frequency");
            end
        end

        % Button pushed function: StopButton
        function StopButtonPushed(app, event)
            audioObj = evalin("base","audioObj");
            stop(audioObj);
            msgbox("The recording is stopped");
        end

        % Button pushed function: PlayandPlotButton
        function PlayandPlotButtonPushed(app, event)
            value = app.WindowTypeRecord.Value;
            w_size = app.WSizeRecord.Value;
            w_shift = app.WShiftRecord.Value;
            bbeta = app.BetaRecord.Value;
            r = app.CosineFractionRecord.Value;
            
            audioObj = evalin("base","audioObj");
            Y = getaudiodata(audioObj);
            Fs = audioObj.SampleRate;
            sound(Y,Fs);
            Length = length(Y)/Fs;
            t = linspace(0,Length, Length*Fs);
            
            plot(app.UITime, t, Y);
            f_plot(app, Y, Fs);
            myspectrogram(app, Y, Fs, w_size, w_shift, value, bbeta, r);
        end

        % Button pushed function: BrowseButton
        function BrowseButtonPushed(app, event)
            [FileName,FilePath]=uigetfile();
            if ~isempty(FileName)
                audio_file = append(FilePath, FileName);
                app.FileEditField.Value = FileName;
                assignin("base","audio_file",audio_file);     
            end
        end

        % Button pushed function: PlayandPlotButton_2
        function PlayandPlotButton_2Pushed(app, event)
            value = app.WindowTypePick.Value;
            w_size = app.WSizePick.Value;
            w_shift = app.WShiftPick.Value;
            bbeta = app.BetaPick.Value;
            r = app.CosineFractionPick.Value;
            
            audio_file = evalin("base","audio_file");
            [X,Fs] = audioread(audio_file);
            Y = X(:,1);
            sound(Y, Fs);                        
            Length = length(Y)/Fs;
            t = linspace(0,Length, Length*Fs);
            
            plot(app.UITime, t, Y);
            f_plot(app, Y, Fs);
            myspectrogram(app, Y, Fs, w_size, w_shift, value, bbeta, r);
        end

        % Value changed function: SignalTypeDropDown
        function SignalTypeDropDownValueChanged(app, event)
            value = app.SignalTypeDropDown.Value;
            
            if strcmp(value, 'Sinusoidal Signal')
                app.AmplitudeEditField.Visible = 'on';
                app.FrequencyEditField.Visible = 'on';
                app.PhaseEditField.Visible = 'on';
                app.DutyCycleEditField.Visible = 'off';
                app.DutyCycleEditFieldLabel.Visible = 'off';
                app.WidthEditField.Visible = 'off';
                app.WidthEditFieldLabel.Visible = 'off';
                app.AddButton.Visible = 'off';
                app.LabelPlease.Visible = 'off';
                app.InitialFrequencyEditField.Visible = 'off';
                app.InitialFrequencyEditFieldLabel.Visible = 'off';
                app.FinalFrequencyEditField.Visible = 'off';
                app.FinalFrequencyEditFieldLabel.Visible = 'off';
                app.FrequencyEditFieldLabel.Visible = 'on';
                
            elseif  strcmp(value, 'Square Wave')
                app.AmplitudeEditField.Visible = 'on';
                app.FrequencyEditField.Visible = 'on';
                app.PhaseEditField.Visible = 'on';
                app.DutyCycleEditField.Visible = 'on';
                app.DutyCycleEditFieldLabel.Visible = 'on';
                app.WidthEditField.Visible = 'off';
                app.WidthEditFieldLabel.Visible = 'off';
                app.AddButton.Visible = 'off';
                app.LabelPlease.Visible = 'off';
                app.InitialFrequencyEditField.Visible = 'off';
                app.InitialFrequencyEditFieldLabel.Visible = 'off';
                app.FinalFrequencyEditField.Visible = 'off';
                app.FinalFrequencyEditFieldLabel.Visible = 'off';
                app.FrequencyEditFieldLabel.Visible = 'on';
                
            elseif  strcmp(value, 'Sawtooth Wave')
                app.AmplitudeEditField.Visible = 'on';
                app.FrequencyEditField.Visible = 'on';
                app.PhaseEditField.Visible = 'on';
                app.DutyCycleEditField.Visible = 'off';
                app.DutyCycleEditFieldLabel.Visible = 'off';
                app.WidthEditField.Visible = 'on';
                app.WidthEditFieldLabel.Visible = 'on';
                app.AddButton.Visible = 'off';
                app.LabelPlease.Visible = 'off';
                app.InitialFrequencyEditField.Visible = 'off';
                app.InitialFrequencyEditFieldLabel.Visible = 'off';
                app.FinalFrequencyEditField.Visible = 'off';
                app.FinalFrequencyEditFieldLabel.Visible = 'off';
                app.FrequencyEditFieldLabel.Visible = 'on';
                
           elseif  strcmp(value, 'Sum of Multiple Sinusoids')
                app.AmplitudeEditField.Visible = 'on';
                app.FrequencyEditField.Visible = 'on';
                app.PhaseEditField.Visible = 'on';
                app.DutyCycleEditField.Visible = 'off';
                app.DutyCycleEditFieldLabel.Visible = 'off';
                app.WidthEditField.Visible = 'off';
                app.WidthEditFieldLabel.Visible = 'off';
                app.AddButton.Visible = 'on';
                app.LabelPlease.Visible = 'on';
                app.InitialFrequencyEditField.Visible = 'off';
                app.InitialFrequencyEditFieldLabel.Visible = 'off';
                app.FinalFrequencyEditField.Visible = 'off';
                app.FinalFrequencyEditFieldLabel.Visible = 'off';
                app.FrequencyEditFieldLabel.Visible = 'on';
            elseif strcmp(value, 'Linear Chirp')
                app.FrequencyEditField.Visible = 'off';
                app.PhaseEditField.Visible = 'on';
                app.DutyCycleEditField.Visible = 'off';
                app.DutyCycleEditFieldLabel.Visible = 'off';
                app.WidthEditField.Visible = 'off';
                app.WidthEditFieldLabel.Visible = 'off';
                app.AddButton.Visible = 'off';
                app.LabelPlease.Visible = 'off';
                app.InitialFrequencyEditField.Visible = 'on';
                app.InitialFrequencyEditFieldLabel.Visible = 'on';
                app.FinalFrequencyEditField.Visible = 'on';
                app.FinalFrequencyEditFieldLabel.Visible = 'on';
                app.FrequencyEditFieldLabel.Visible = 'off';
                
            end
            
        end

        % Button pushed function: GenerateButton
        function GenerateButtonPushed(app, event)
            value = app.SignalTypeDropDown.Value;
            win_type = app.WindowTypeGen.Value;
            w_size = app.WSizeGen.Value;
            w_shift = app.WShiftGen.Value;
            bbeta = app.BetaGen.Value;
            r = app.CosineFractionGen.Value;
            Fs = app.SamplingFrequencyEditField.Value;
            Ac = app.AmplitudeEditField.Value;
            Length = app.TotalLengthsecEditField.Value;
            
            if strcmp(value, 'Sinusoidal Signal')
                [t,signal] = sinusoidal_signal(app);
                
                plot(app.UITime, t, signal);
                app.UITime.YLim = [-Ac-1 Ac+1];
                
                f_plot(app, signal, Fs);
                myspectrogram(app, signal, Fs, w_size, w_shift,win_type, bbeta, r);
                
            elseif  strcmp(value, 'Square Wave')
                [t,signal] = square_wave(app);
                
                plot(app.UITime, t, signal);
                app.UITime.YLim = [-Ac-1 Ac+1];
            
                f_plot(app, signal, Fs);
                myspectrogram(app, signal, Fs, w_size, w_shift,win_type, bbeta, r);
                
            elseif  strcmp(value, 'Sawtooth Wave')
                [t,signal] = sawtooth_wave(app);
                
                plot(app.UITime, t, signal);
                app.UITime.YLim = [-Ac-1 Ac+1];
                
                f_plot(app, signal, Fs);
                myspectrogram(app, signal, Fs, w_size, w_shift,win_type, bbeta, r);
                
            elseif  strcmp(value, 'Linear Chirp')
                [t,signal] = mychirp(app);
                
                plot(app.UITime, t, signal);
                app.UITime.YLim = [-Ac-1 Ac+1];
                
                f_plot(app, signal, Fs);
                myspectrogram(app, signal, Fs, w_size, w_shift,win_type, bbeta, r);
                
            elseif  strcmp(value, 'Sum of Multiple Sinusoids')
                signal = evalin("base","sum_sinusoids");
                t = linspace(0,Length, Length*Fs);
                plot(app.UITime, t, signal);
                f_plot(app, signal, Fs);
                myspectrogram(app, signal, Fs, w_size, w_shift,win_type, bbeta, r);
                
                sum_sinusoids = [];
                assignin("base","sum_sinusoids",sum_sinusoids); 
                
            end
        end

        % Button pushed function: AddButton
        function AddButtonPushed(app, event)
            sum_sinusoids = evalin("base","sum_sinusoids");
            [t, signal] = sinusoidal_signal(app);
            if isempty(sum_sinusoids)
                sum_sinusoids = signal;
            else
                sum_sinusoids = sum_sinusoids + signal;
            end
            assignin("base","sum_sinusoids",sum_sinusoids); 
            
        end

        % Button pushed function: AppendButton
        function AppendButtonPushed(app, event)
            value = app.SignalTypeDropDown.Value;
            appended_signals = evalin("base","appended_signals");
            
            if strcmp(value, 'Sinusoidal Signal')
                [t,signal] = sinusoidal_signal(app);
                
            elseif  strcmp(value, 'Square Wave')
                [t, signal] = square_wave(app);       
                
            elseif  strcmp(value, 'Sawtooth Wave')
                [t, signal] = sawtooth_wave(app);
                
            elseif  strcmp(value, 'Linear Chirp')
                [t, signal] = mychirp(app);   
               
            elseif  strcmp(value, 'Sum of Multiple Sinusoids')
                signal = evalin("base","sum_sinusoids"); 
                
            end
            
            appended_signals = [appended_signals, signal];
            assignin("base","appended_signals",appended_signals); 
        end

        % Button pushed function: GenerateAppendButton
        function GenerateAppendButtonPushed(app, event)
            Fs = app.SamplingFrequencyEditField.Value;
            
            win_type = app.WindowTypeGen.Value;
            w_size = app.WSizeGen.Value;
            w_shift = app.WShiftGen.Value;
            bbeta = app.BetaGen.Value;
            r = app.CosineFractionGen.Value;
            
            
            appended_signals = evalin("base","appended_signals");
            len = length(appended_signals)/Fs;
            t = linspace(0,len, len*Fs);
            plot(app.UITime, t, appended_signals);
            f_plot(app, appended_signals, Fs);
            myspectrogram(app, appended_signals, Fs, w_size, w_shift, win_type, bbeta, r);
                   
            
        end

        % Value changed function: WindowTypeRecord
        function WindowTypeRecordValueChanged(app, event)
            value = app.WindowTypeRecord.Value;
            
            if strcmp(value, 'Hamming')
                app.CosineFractionRecord.Visible = 'off';
                app.BetaRecord.Visible = 'off';
                app.CosineFractionEditFieldLabel.Visible = 'Off';
                app.BetaEditFieldLabel.Visible = 'off';
            elseif strcmp(value, 'Rectangle')
                app.CosineFractionRecord.Visible = 'off';
                app.BetaRecord.Visible = 'off';
                app.CosineFractionEditFieldLabel.Visible = 'Off';
                app.BetaEditFieldLabel.Visible = 'off';
            elseif strcmp(value, 'Hanning')
                app.CosineFractionRecord.Visible = 'off';
                app.BetaRecord.Visible = 'off';
                app.CosineFractionEditFieldLabel.Visible = 'Off';
                app.BetaEditFieldLabel.Visible = 'off';
            elseif strcmp(value, 'Kaiser')
                app.CosineFractionRecord.Visible = 'off';
                app.BetaRecord.Visible = 'on';
                app.CosineFractionEditFieldLabel.Visible = 'Off';
                app.BetaEditFieldLabel.Visible = 'on';
            elseif strcmp(value, 'Blackman')
                app.CosineFractionRecord.Visible = 'off';
                app.BetaRecord.Visible = 'off';
                app.CosineFractionEditFieldLabel.Visible = 'Off';
                app.BetaEditFieldLabel.Visible = 'off';
            elseif strcmp(value, 'Gaussian')
                app.CosineFractionRecord.Visible = 'off';
                app.BetaRecord.Visible = 'off';
                app.CosineFractionEditFieldLabel.Visible = 'Off';
                app.BetaEditFieldLabel.Visible = 'off';
            elseif strcmp(value, 'Tukey')
                app.CosineFractionRecord.Visible = 'on';
                app.BetaRecord.Visible = 'off';
                app.CosineFractionEditFieldLabel.Visible = 'on';
                app.BetaEditFieldLabel.Visible = 'off';
                
            end
        end

        % Value changed function: WindowTypePick
        function WindowTypePickValueChanged(app, event)
            value = app.WindowTypePick.Value;
            
            if strcmp(value, 'Hamming')
                app.CosineFractionPick.Visible = 'off';
                app.BetaPick.Visible = 'off'; 
                app.CosineFractionEditField_2Label.Visible = 'off';
                app.BetaEditField_2Label.Visible = 'off';
            elseif strcmp(value, 'Rectangle')
                app.CosineFractionRecord.Visible = 'off';
                app.BetaRecord.Visible = 'off';
                app.CosineFractionEditField_2Label.Visible = 'off';
                app.BetaEditField_2Label.Visible = 'off';
            elseif strcmp(value, 'Hanning')
                app.CosineFractionPick.Visible = 'off';
                app.BetaPick.Visible = 'off'; 
                app.CosineFractionEditField_2Label.Visible = 'off';
                app.BetaEditField_2Label.Visible = 'off';
            elseif strcmp(value, 'Kaiser')
                app.CosineFractionPick.Visible = 'off';
                app.BetaPick.Visible = 'on'; 
                app.CosineFractionEditField_2Label.Visible = 'off';
                app.BetaEditField_2Label.Visible = 'on';
            elseif strcmp(value, 'Blackman')
                app.CosineFractionPick.Visible = 'off';
                app.BetaPick.Visible = 'off'; 
                app.CosineFractionEditField_2Label.Visible = 'off';
                app.BetaEditField_2Label.Visible = 'off';
            elseif strcmp(value, 'Gaussian')
                app.CosineFractionPick.Visible = 'off';
                app.BetaPick.Visible = 'off'; 
                app.CosineFractionEditField_2Label.Visible = 'off';
                app.BetaEditField_2Label.Visible = 'off';
            elseif strcmp(value, 'Tukey')
                app.CosineFractionPick.Visible = 'on';
                app.BetaPick.Visible = 'off'; 
                app.CosineFractionEditField_2Label.Visible = 'on';
                app.BetaEditField_2Label.Visible = 'off';
                
            end
        end

        % Value changed function: WindowTypeGen
        function WindowTypeGenValueChanged(app, event)
            value = app.WindowTypeGen.Value;
            
            
            if strcmp(value, 'Hamming')
                app.CosineFractionGen.Visible = 'off';
                app.BetaGen.Visible = 'off';
                app.CosineFractionEditFieldLabel_2.Visible = 'off';
                app.BetaEditFieldLabel_2.Visible = 'off';
            elseif strcmp(value, 'Rectangle')
                app.CosineFractionGen.Visible = 'off';
                app.BetaGen.Visible = 'off';
                app.CosineFractionEditFieldLabel_2.Visible = 'off';
                app.BetaEditFieldLabel_2.Visible = 'off';
            elseif strcmp(value, 'Hanning')
                app.CosineFractionGen.Visible = 'off';
                app.BetaGen.Visible = 'off'; 
                app.CosineFractionEditFieldLabel_2.Visible = 'off';
                app.BetaEditFieldLabel_2.Visible = 'off';
            elseif strcmp(value, 'Kaiser')
                app.CosineFractionGen.Visible = 'off';
                app.BetaGen.Visible = 'on';
                app.CosineFractionEditFieldLabel_2.Visible = 'off';
                app.BetaEditFieldLabel_2.Visible = 'on';
            elseif strcmp(value, 'Blackman')
                app.CosineFractionGen.Visible = 'off';
                app.BetaGen.Visible = 'off'; 
                app.CosineFractionEditFieldLabel_2.Visible = 'off';
                app.BetaEditFieldLabel_2.Visible = 'off';
            elseif strcmp(value, 'Gaussian')
                app.CosineFractionGen.Visible = 'off';
                app.BetaGen.Visible = 'off';
                app.CosineFractionEditFieldLabel_2.Visible = 'off';
                app.BetaEditFieldLabel_2.Visible = 'off';
            elseif strcmp(value, 'Tukey')
                app.CosineFractionGen.Visible = 'on';
                app.BetaGen.Visible = 'off';
                app.CosineFractionEditFieldLabel_2.Visible = 'on';
                app.BetaEditFieldLabel_2.Visible = 'off';
                
            end
        end

        % Button pushed function: ClearAppendButton
        function ClearAppendButtonPushed(app, event)
            appended_signals = [];
            assignin("base","appended_signals",appended_signals);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1019 745];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 532 1021 214];

            % Create SoundRecorderTab
            app.SoundRecorderTab = uitab(app.TabGroup);
            app.SoundRecorderTab.Title = 'Sound Recorder';

            % Create SoundRecorderLabel
            app.SoundRecorderLabel = uilabel(app.SoundRecorderTab);
            app.SoundRecorderLabel.FontSize = 20;
            app.SoundRecorderLabel.FontWeight = 'bold';
            app.SoundRecorderLabel.Position = [503 148 161 25];
            app.SoundRecorderLabel.Text = 'Sound Recorder';

            % Create FsEditFieldLabel
            app.FsEditFieldLabel = uilabel(app.SoundRecorderTab);
            app.FsEditFieldLabel.HorizontalAlignment = 'right';
            app.FsEditFieldLabel.Position = [494 114 25 22];
            app.FsEditFieldLabel.Text = 'Fs';

            % Create FsEditField
            app.FsEditField = uieditfield(app.SoundRecorderTab, 'numeric');
            app.FsEditField.Position = [534 114 100 22];

            % Create StartButton
            app.StartButton = uibutton(app.SoundRecorderTab, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.Position = [534 74 100 22];
            app.StartButton.Text = 'Start';

            % Create StopButton
            app.StopButton = uibutton(app.SoundRecorderTab, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @StopButtonPushed, true);
            app.StopButton.Position = [534 41 100 22];
            app.StopButton.Text = 'Stop';

            % Create PlayandPlotButton
            app.PlayandPlotButton = uibutton(app.SoundRecorderTab, 'push');
            app.PlayandPlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlayandPlotButtonPushed, true);
            app.PlayandPlotButton.Position = [534 9 100 22];
            app.PlayandPlotButton.Text = 'Play and Plot';

            % Create WindowSizeEditFieldLabel
            app.WindowSizeEditFieldLabel = uilabel(app.SoundRecorderTab);
            app.WindowSizeEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowSizeEditFieldLabel.Position = [228 41 75 22];
            app.WindowSizeEditFieldLabel.Text = 'Window Size';

            % Create WSizeRecord
            app.WSizeRecord = uieditfield(app.SoundRecorderTab, 'numeric');
            app.WSizeRecord.Limits = [1 Inf];
            app.WSizeRecord.Position = [318 41 100 22];
            app.WSizeRecord.Value = 1;

            % Create WindowShiftEditFieldLabel
            app.WindowShiftEditFieldLabel = uilabel(app.SoundRecorderTab);
            app.WindowShiftEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowShiftEditFieldLabel.Position = [227 20 76 22];
            app.WindowShiftEditFieldLabel.Text = 'Window Shift';

            % Create WShiftRecord
            app.WShiftRecord = uieditfield(app.SoundRecorderTab, 'numeric');
            app.WShiftRecord.Limits = [1 Inf];
            app.WShiftRecord.Position = [318 20 100 22];
            app.WShiftRecord.Value = 1;

            % Create WindowTypeDropDown_2Label
            app.WindowTypeDropDown_2Label = uilabel(app.SoundRecorderTab);
            app.WindowTypeDropDown_2Label.HorizontalAlignment = 'right';
            app.WindowTypeDropDown_2Label.Position = [225 149 78 22];
            app.WindowTypeDropDown_2Label.Text = 'Window Type';

            % Create WindowTypeRecord
            app.WindowTypeRecord = uidropdown(app.SoundRecorderTab);
            app.WindowTypeRecord.Items = {'Hamming', 'Rectangle', 'Hanning', 'Tukey', 'Kaiser', 'Blackman', 'Gaussian'};
            app.WindowTypeRecord.ValueChangedFcn = createCallbackFcn(app, @WindowTypeRecordValueChanged, true);
            app.WindowTypeRecord.Position = [318 149 100 22];
            app.WindowTypeRecord.Value = 'Hamming';

            % Create CosineFractionEditFieldLabel
            app.CosineFractionEditFieldLabel = uilabel(app.SoundRecorderTab);
            app.CosineFractionEditFieldLabel.HorizontalAlignment = 'right';
            app.CosineFractionEditFieldLabel.Position = [213 62 90 22];
            app.CosineFractionEditFieldLabel.Text = 'Cosine Fraction';

            % Create CosineFractionRecord
            app.CosineFractionRecord = uieditfield(app.SoundRecorderTab, 'numeric');
            app.CosineFractionRecord.Limits = [0 1];
            app.CosineFractionRecord.Position = [318 62 100 22];

            % Create BetaEditFieldLabel
            app.BetaEditFieldLabel = uilabel(app.SoundRecorderTab);
            app.BetaEditFieldLabel.HorizontalAlignment = 'right';
            app.BetaEditFieldLabel.Position = [273 83 30 22];
            app.BetaEditFieldLabel.Text = 'Beta';

            % Create BetaRecord
            app.BetaRecord = uieditfield(app.SoundRecorderTab, 'numeric');
            app.BetaRecord.Limits = [0 Inf];
            app.BetaRecord.Position = [318 83 100 22];

            % Create WindowParametersLabel
            app.WindowParametersLabel = uilabel(app.SoundRecorderTab);
            app.WindowParametersLabel.Position = [302 119 114 22];
            app.WindowParametersLabel.Text = 'Window Parameters';

            % Create PickaSoundTab
            app.PickaSoundTab = uitab(app.TabGroup);
            app.PickaSoundTab.Title = 'Pick a Sound';

            % Create PickaSoundLabel
            app.PickaSoundLabel = uilabel(app.PickaSoundTab);
            app.PickaSoundLabel.FontSize = 20;
            app.PickaSoundLabel.FontWeight = 'bold';
            app.PickaSoundLabel.Position = [504 148 161 25];
            app.PickaSoundLabel.Text = 'Pick a Sound';

            % Create FileEditFieldLabel
            app.FileEditFieldLabel = uilabel(app.PickaSoundTab);
            app.FileEditFieldLabel.HorizontalAlignment = 'right';
            app.FileEditFieldLabel.Position = [496 115 25 22];
            app.FileEditFieldLabel.Text = 'File';

            % Create FileEditField
            app.FileEditField = uieditfield(app.PickaSoundTab, 'text');
            app.FileEditField.Editable = 'off';
            app.FileEditField.Position = [535 114 100 22];

            % Create BrowseButton
            app.BrowseButton = uibutton(app.PickaSoundTab, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.BrowseButton.Position = [535 74 100 22];
            app.BrowseButton.Text = 'Browse';

            % Create PlayandPlotButton_2
            app.PlayandPlotButton_2 = uibutton(app.PickaSoundTab, 'push');
            app.PlayandPlotButton_2.ButtonPushedFcn = createCallbackFcn(app, @PlayandPlotButton_2Pushed, true);
            app.PlayandPlotButton_2.Position = [535 41 100 22];
            app.PlayandPlotButton_2.Text = 'Play and Plot';

            % Create WindowSizeEditFieldLabel_2
            app.WindowSizeEditFieldLabel_2 = uilabel(app.PickaSoundTab);
            app.WindowSizeEditFieldLabel_2.HorizontalAlignment = 'right';
            app.WindowSizeEditFieldLabel_2.Position = [226 41 75 22];
            app.WindowSizeEditFieldLabel_2.Text = 'Window Size';

            % Create WSizePick
            app.WSizePick = uieditfield(app.PickaSoundTab, 'numeric');
            app.WSizePick.Limits = [1 Inf];
            app.WSizePick.Position = [316 41 100 22];
            app.WSizePick.Value = 1;

            % Create WindowShiftEditFieldLabel_2
            app.WindowShiftEditFieldLabel_2 = uilabel(app.PickaSoundTab);
            app.WindowShiftEditFieldLabel_2.HorizontalAlignment = 'right';
            app.WindowShiftEditFieldLabel_2.Position = [225 20 76 22];
            app.WindowShiftEditFieldLabel_2.Text = 'Window Shift';

            % Create WShiftPick
            app.WShiftPick = uieditfield(app.PickaSoundTab, 'numeric');
            app.WShiftPick.Limits = [1 Inf];
            app.WShiftPick.Position = [316 20 100 22];
            app.WShiftPick.Value = 1;

            % Create CosineFractionEditField_2Label
            app.CosineFractionEditField_2Label = uilabel(app.PickaSoundTab);
            app.CosineFractionEditField_2Label.HorizontalAlignment = 'right';
            app.CosineFractionEditField_2Label.Position = [211 62 90 22];
            app.CosineFractionEditField_2Label.Text = 'Cosine Fraction';

            % Create CosineFractionPick
            app.CosineFractionPick = uieditfield(app.PickaSoundTab, 'numeric');
            app.CosineFractionPick.Limits = [0 1];
            app.CosineFractionPick.Position = [316 62 100 22];

            % Create WindowTypeDropDown_2Label_2
            app.WindowTypeDropDown_2Label_2 = uilabel(app.PickaSoundTab);
            app.WindowTypeDropDown_2Label_2.HorizontalAlignment = 'right';
            app.WindowTypeDropDown_2Label_2.Position = [218 149 78 22];
            app.WindowTypeDropDown_2Label_2.Text = 'Window Type';

            % Create WindowTypePick
            app.WindowTypePick = uidropdown(app.PickaSoundTab);
            app.WindowTypePick.Items = {'Hamming', 'Rectangle', 'Hanning', 'Tukey', 'Kaiser', 'Blackman', 'Gaussian'};
            app.WindowTypePick.ValueChangedFcn = createCallbackFcn(app, @WindowTypePickValueChanged, true);
            app.WindowTypePick.Position = [311 149 100 22];
            app.WindowTypePick.Value = 'Hamming';

            % Create BetaEditField_2Label
            app.BetaEditField_2Label = uilabel(app.PickaSoundTab);
            app.BetaEditField_2Label.HorizontalAlignment = 'right';
            app.BetaEditField_2Label.Position = [271 83 30 22];
            app.BetaEditField_2Label.Text = 'Beta';

            % Create BetaPick
            app.BetaPick = uieditfield(app.PickaSoundTab, 'numeric');
            app.BetaPick.Limits = [0 Inf];
            app.BetaPick.Position = [316 83 100 22];

            % Create WindowParametersLabel_2
            app.WindowParametersLabel_2 = uilabel(app.PickaSoundTab);
            app.WindowParametersLabel_2.Position = [302 119 114 22];
            app.WindowParametersLabel_2.Text = 'Window Parameters';

            % Create GenerateSignalTab
            app.GenerateSignalTab = uitab(app.TabGroup);
            app.GenerateSignalTab.Title = 'Generate Signal';

            % Create SignalTypeDropDownLabel
            app.SignalTypeDropDownLabel = uilabel(app.GenerateSignalTab);
            app.SignalTypeDropDownLabel.HorizontalAlignment = 'right';
            app.SignalTypeDropDownLabel.Position = [4 119 68 22];
            app.SignalTypeDropDownLabel.Text = 'Signal Type';

            % Create SignalTypeDropDown
            app.SignalTypeDropDown = uidropdown(app.GenerateSignalTab);
            app.SignalTypeDropDown.Items = {'Sinusoidal Signal', 'Sum of Multiple Sinusoids', 'Square Wave', 'Sawtooth Wave', 'Linear Chirp'};
            app.SignalTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @SignalTypeDropDownValueChanged, true);
            app.SignalTypeDropDown.Position = [87 119 195 22];
            app.SignalTypeDropDown.Value = 'Sinusoidal Signal';

            % Create GenerateaSignalLabel
            app.GenerateaSignalLabel = uilabel(app.GenerateSignalTab);
            app.GenerateaSignalLabel.FontSize = 20;
            app.GenerateaSignalLabel.FontWeight = 'bold';
            app.GenerateaSignalLabel.Position = [38 148 179 25];
            app.GenerateaSignalLabel.Text = 'Generate a Signal';

            % Create SamplingFrequencyEditFieldLabel
            app.SamplingFrequencyEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.SamplingFrequencyEditFieldLabel.HorizontalAlignment = 'right';
            app.SamplingFrequencyEditFieldLabel.Position = [6 54 115 22];
            app.SamplingFrequencyEditFieldLabel.Text = 'Sampling Frequency';

            % Create SamplingFrequencyEditField
            app.SamplingFrequencyEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.SamplingFrequencyEditField.Position = [136 54 67 22];
            app.SamplingFrequencyEditField.Value = 1000;

            % Create TotalLengthsecEditFieldLabel
            app.TotalLengthsecEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.TotalLengthsecEditFieldLabel.HorizontalAlignment = 'right';
            app.TotalLengthsecEditFieldLabel.Position = [20 20 101 22];
            app.TotalLengthsecEditFieldLabel.Text = 'Total Length (sec)';

            % Create TotalLengthsecEditField
            app.TotalLengthsecEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.TotalLengthsecEditField.Position = [136 20 66 22];

            % Create GenerateButton
            app.GenerateButton = uibutton(app.GenerateSignalTab, 'push');
            app.GenerateButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateButtonPushed, true);
            app.GenerateButton.Position = [688 59 100 22];
            app.GenerateButton.Text = 'Generate';

            % Create AmplitudeEditFieldLabel
            app.AmplitudeEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.AmplitudeEditFieldLabel.HorizontalAlignment = 'right';
            app.AmplitudeEditFieldLabel.Position = [322 53 59 22];
            app.AmplitudeEditFieldLabel.Text = 'Amplitude';

            % Create AmplitudeEditField
            app.AmplitudeEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.AmplitudeEditField.Position = [396 53 63 22];

            % Create FrequencyEditFieldLabel
            app.FrequencyEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.FrequencyEditFieldLabel.HorizontalAlignment = 'right';
            app.FrequencyEditFieldLabel.Position = [319 33 62 22];
            app.FrequencyEditFieldLabel.Text = 'Frequency';

            % Create FrequencyEditField
            app.FrequencyEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.FrequencyEditField.Position = [396 33 63 22];

            % Create PhaseEditFieldLabel
            app.PhaseEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.PhaseEditFieldLabel.HorizontalAlignment = 'right';
            app.PhaseEditFieldLabel.Position = [342 12 39 22];
            app.PhaseEditFieldLabel.Text = 'Phase';

            % Create PhaseEditField
            app.PhaseEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.PhaseEditField.Position = [396 12 63 22];

            % Create DutyCycleEditFieldLabel
            app.DutyCycleEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.DutyCycleEditFieldLabel.HorizontalAlignment = 'right';
            app.DutyCycleEditFieldLabel.Position = [318 135 63 22];
            app.DutyCycleEditFieldLabel.Text = 'Duty Cycle';

            % Create DutyCycleEditField
            app.DutyCycleEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.DutyCycleEditField.Position = [396 135 63 22];

            % Create WidthEditFieldLabel
            app.WidthEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.WidthEditFieldLabel.HorizontalAlignment = 'right';
            app.WidthEditFieldLabel.Position = [345 114 36 22];
            app.WidthEditFieldLabel.Text = 'Width';

            % Create WidthEditField
            app.WidthEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.WidthEditField.Limits = [0 1];
            app.WidthEditField.Position = [396 114 63 22];

            % Create AddButton
            app.AddButton = uibutton(app.GenerateSignalTab, 'push');
            app.AddButton.ButtonPushedFcn = createCallbackFcn(app, @AddButtonPushed, true);
            app.AddButton.Position = [688 93 100 22];
            app.AddButton.Text = 'Add';

            % Create LabelPlease
            app.LabelPlease = uilabel(app.GenerateSignalTab);
            app.LabelPlease.Position = [6 80 242 22];
            app.LabelPlease.Text = 'Please Do not change the above two values';

            % Create AppendButton
            app.AppendButton = uibutton(app.GenerateSignalTab, 'push');
            app.AppendButton.ButtonPushedFcn = createCallbackFcn(app, @AppendButtonPushed, true);
            app.AppendButton.Position = [865 95 100 22];
            app.AppendButton.Text = 'Append';

            % Create GenerateAppendButton
            app.GenerateAppendButton = uibutton(app.GenerateSignalTab, 'push');
            app.GenerateAppendButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateAppendButtonPushed, true);
            app.GenerateAppendButton.Position = [860 62 110 22];
            app.GenerateAppendButton.Text = 'Generate Append';

            % Create WindowSizeEditFieldLabel_3
            app.WindowSizeEditFieldLabel_3 = uilabel(app.GenerateSignalTab);
            app.WindowSizeEditFieldLabel_3.HorizontalAlignment = 'right';
            app.WindowSizeEditFieldLabel_3.Position = [504 72 75 22];
            app.WindowSizeEditFieldLabel_3.Text = 'Window Size';

            % Create WSizeGen
            app.WSizeGen = uieditfield(app.GenerateSignalTab, 'numeric');
            app.WSizeGen.Limits = [1 Inf];
            app.WSizeGen.Position = [594 72 60 22];
            app.WSizeGen.Value = 1;

            % Create WindowShiftEditFieldLabel_3
            app.WindowShiftEditFieldLabel_3 = uilabel(app.GenerateSignalTab);
            app.WindowShiftEditFieldLabel_3.HorizontalAlignment = 'right';
            app.WindowShiftEditFieldLabel_3.Position = [503 54 76 22];
            app.WindowShiftEditFieldLabel_3.Text = 'Window Shift';

            % Create WShiftGen
            app.WShiftGen = uieditfield(app.GenerateSignalTab, 'numeric');
            app.WShiftGen.Limits = [1 Inf];
            app.WShiftGen.Position = [594 54 60 22];
            app.WShiftGen.Value = 1;

            % Create CosineFractionEditFieldLabel_2
            app.CosineFractionEditFieldLabel_2 = uilabel(app.GenerateSignalTab);
            app.CosineFractionEditFieldLabel_2.HorizontalAlignment = 'right';
            app.CosineFractionEditFieldLabel_2.Position = [489 93 90 22];
            app.CosineFractionEditFieldLabel_2.Text = 'Cosine Fraction';

            % Create CosineFractionGen
            app.CosineFractionGen = uieditfield(app.GenerateSignalTab, 'numeric');
            app.CosineFractionGen.Limits = [0 1];
            app.CosineFractionGen.Position = [594 93 60 22];

            % Create BetaEditFieldLabel_2
            app.BetaEditFieldLabel_2 = uilabel(app.GenerateSignalTab);
            app.BetaEditFieldLabel_2.HorizontalAlignment = 'right';
            app.BetaEditFieldLabel_2.Position = [549 114 30 22];
            app.BetaEditFieldLabel_2.Text = 'Beta';

            % Create BetaGen
            app.BetaGen = uieditfield(app.GenerateSignalTab, 'numeric');
            app.BetaGen.Limits = [0 Inf];
            app.BetaGen.Position = [594 114 60 22];

            % Create WindowTypeDropDown_2Label_3
            app.WindowTypeDropDown_2Label_3 = uilabel(app.GenerateSignalTab);
            app.WindowTypeDropDown_2Label_3.HorizontalAlignment = 'right';
            app.WindowTypeDropDown_2Label_3.Position = [472 149 78 22];
            app.WindowTypeDropDown_2Label_3.Text = 'Window Type';

            % Create WindowTypeGen
            app.WindowTypeGen = uidropdown(app.GenerateSignalTab);
            app.WindowTypeGen.Items = {'Hamming', 'Rectangle', 'Hanning', 'Tukey', 'Kaiser', 'Blackman', 'Gaussian'};
            app.WindowTypeGen.ValueChangedFcn = createCallbackFcn(app, @WindowTypeGenValueChanged, true);
            app.WindowTypeGen.Position = [565 149 100 22];
            app.WindowTypeGen.Value = 'Hamming';

            % Create InitialFrequencyEditFieldLabel
            app.InitialFrequencyEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.InitialFrequencyEditFieldLabel.HorizontalAlignment = 'right';
            app.InitialFrequencyEditFieldLabel.Position = [279 93 94 22];
            app.InitialFrequencyEditFieldLabel.Text = 'Initial Frequency';

            % Create InitialFrequencyEditField
            app.InitialFrequencyEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.InitialFrequencyEditField.Position = [396 93 63 22];

            % Create FinalFrequencyEditFieldLabel
            app.FinalFrequencyEditFieldLabel = uilabel(app.GenerateSignalTab);
            app.FinalFrequencyEditFieldLabel.HorizontalAlignment = 'right';
            app.FinalFrequencyEditFieldLabel.Position = [279 72 92 22];
            app.FinalFrequencyEditFieldLabel.Text = 'Final Frequency';

            % Create FinalFrequencyEditField
            app.FinalFrequencyEditField = uieditfield(app.GenerateSignalTab, 'numeric');
            app.FinalFrequencyEditField.Position = [396 72 63 22];

            % Create ClearAppendButton
            app.ClearAppendButton = uibutton(app.GenerateSignalTab, 'push');
            app.ClearAppendButton.ButtonPushedFcn = createCallbackFcn(app, @ClearAppendButtonPushed, true);
            app.ClearAppendButton.Position = [865 30 100 22];
            app.ClearAppendButton.Text = 'Clear Append';

            % Create TocreateconcatenatedsignalswithdifferenttypesuseappendtoolLabel
            app.TocreateconcatenatedsignalswithdifferenttypesuseappendtoolLabel = uilabel(app.GenerateSignalTab);
            app.TocreateconcatenatedsignalswithdifferenttypesuseappendtoolLabel.HorizontalAlignment = 'center';
            app.TocreateconcatenatedsignalswithdifferenttypesuseappendtoolLabel.Position = [813 128 202 42];
            app.TocreateconcatenatedsignalswithdifferenttypesuseappendtoolLabel.Text = {'To create concatenated signals '; 'with different types use append tool.'; 'Select any signal type then append '};

            % Create TabGroup2
            app.TabGroup2 = uitabgroup(app.UIFigure);
            app.TabGroup2.Position = [1 -3 1021 537];

            % Create TimeDomainTab
            app.TimeDomainTab = uitab(app.TabGroup2);
            app.TimeDomainTab.Title = 'Time Domain';

            % Create UITime
            app.UITime = uiaxes(app.TimeDomainTab);
            title(app.UITime, 'Signal in Time Domain')
            xlabel(app.UITime, 'X')
            ylabel(app.UITime, 'Y')
            app.UITime.Position = [4 4 1011 504];

            % Create FrequencyDomainTab
            app.FrequencyDomainTab = uitab(app.TabGroup2);
            app.FrequencyDomainTab.Title = 'Frequency Domain';

            % Create UIFrequency
            app.UIFrequency = uiaxes(app.FrequencyDomainTab);
            title(app.UIFrequency, 'Signal in Frequency Domain')
            xlabel(app.UIFrequency, 'X')
            ylabel(app.UIFrequency, 'Y')
            app.UIFrequency.Position = [4 4 1011 504];

            % Create SpectogramTab
            app.SpectogramTab = uitab(app.TabGroup2);
            app.SpectogramTab.Title = 'Spectogram';

            % Create UISpec
            app.UISpec = uiaxes(app.SpectogramTab);
            title(app.UISpec, 'Spectrogram of a Signal')
            xlabel(app.UISpec, 'X')
            ylabel(app.UISpec, 'Y')
            app.UISpec.Position = [4 3 1012 505];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = project_2231470_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end