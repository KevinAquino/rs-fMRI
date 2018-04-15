%% run_prepro:
% Copyright (C) 2017, Linden Parkes <lindenparkes@gmail.com>,
% Inputs (essential):
% WhichProject      - A text string that selects which dataset to process. You will need to add your own below (see cfg.WhichProject)
%                   if using this code on your own data.
% WhichSessScan     - A text string that can be used to differentiate different scans in a multi-scan protocol.
%                   if you only have a single scan then you can use 'Sess1_Scan1'
% subject           - A text string identifying the subject
% smoothing         - A text string with three options: 'none', 'before', 'after'
%                   This sets whether spatial smoothing is done before denosiing ('before'), after denoising ('after'), or not at all ('none')
%                   Note, the code will overwrite this input and set it to 'before' in cases where ICA-AROMA is used
% 
% Inputs (optional)
% discard           - toggles whether 4 volumes of the EPI are discarded (1) or not (0). Default = 1
% slicetime         - toggles slice time correction. on (1) off (0). Default = 1
% despike           - toggles despiking. on (1) off (0). Default = 0
% detr              - toggles linear detrending. on (1) off (0). Default = 1
% intnorm           - toggles intensity normalisation. on (1) off (0). Default = 1
% bandpass          - toggles bandpass filtering. on (1) off (0). Default = 1
% demean            - toggles demeaning. on (1) off (0). Default = 1
% 
% For an example of how to set up a project, see section:
    % switch cfg.WhichProject
        % case 'OCDPG'

function [] = run_prepro(WhichProject,WhichSessScan,subject,smoothing,discard,slicetime,despike,detr,intnorm,bandpass,demean)
    cfg.WhichProject = WhichProject;
    cfg.WhichSessScan = WhichSessScan;
    cfg.subject = subject;
    % preprocessing options
    if nargin < 5
        cfg.discard = 1;
    else
        cfg.discard = discard;
    end

    if nargin < 6
        cfg.slicetime = 1;
    else
        cfg.slicetime = slicetime;
    end

    if nargin < 7
        cfg.despike = 0;
    else
        cfg.despike = despike;
    end

    if nargin < 8
        cfg.detr = 1;
    else
        cfg.detr = detr;
    end

    if nargin < 9
        cfg.intnorm = 1;
    else
        cfg.intnorm = intnorm;
    end

    if nargin < 10
        cfg.runBandpass = 1;
    else
        cfg.runBandpass = bandpass;
    end

    if nargin < 11
        cfg.demean = 1;
    else
        cfg.demean = demean;
    end

    % ------------------------------------------------------------------------------
    % Store date and time
    % ------------------------------------------------------------------------------
    cfg.DateTime = datetime('now');

    % ------------------------------------------------------------------------------
    % Parent dir
    % ------------------------------------------------------------------------------
    cfg.parentdir = '/home/kaqu0001/kg98/kevo/';
    cfg.parentdir_scratch = '/home/kaqu0001/kg98_scratch/kevo/';

    % ------------------------------------------------------------------------------
    % Add paths - edit this section
    % ------------------------------------------------------------------------------
    % where the prepro scripts are
    cfg.scriptdir = [cfg.parentdir,'Scripts/rs-fMRI/prepro/'];
    addpath(cfg.scriptdir)
    cfg.funcdir = [cfg.parentdir,'Scripts/rs-fMRI/func/'];
    addpath(cfg.funcdir)

    % where spm is
    cfg.spmdir = '/usr/local/spm8/matlab2015b.r6685/';
    addpath(cfg.spmdir)

    % set FSL environments
    cfg.fsldir = '/usr/local/fsl/5.0.9/fsl/bin/';
    setenv('FSLDIR',cfg.fsldir(1:end-4));
    setenv('FSLOUTPUTTYPE','NIFTI');
    setenv('LD_LIBRARY_PATH',[getenv('PATH'),getenv('LD_LIBRARY_PATH'),':/usr/lib/fsl/5.0'])

    % where ICA-AROMA scripts are
    cfg.scriptdir_ICA = [cfg.parentdir,'Scripts/Tools/ICA-AROMA/'];

    % ANTs
    cfg.antsdir = '/usr/local/ants/1.9.v4/bin/';
    setenv('ANTSPATH',cfg.antsdir);

    % Directory to AFNI functions
    cfg.afnidir = '/usr/local/afni/16.2.16/';

    % ------------------------------------------------------------------------------
    % Set project settings and parameters
    % These are now set in config files inside the folder rs-fMRI/studies
    %
    % Use WhichProject if you're juggling multiple datasets
            % cfg.order = [1:1:cfg.numSlices]; % ascending
            % cfg.order = [cfg.numSlices:-1:1]; % descending
            % cfg.order = [1:2:cfg.numSlices,2:2:cfg.numSlices]; % interleaved
            % cfg.order = [2:2:cfg.numSlices, 1:2:cfg.numSlices-1]; %interleave alt
            % Reference slice for slice timing acquisition. See SlicetimeEPI.m for guidance on how to define.
            % cfg.refSlice = round(cfg.numSlices/2); % use for sequential order (e.g., ascending or descending)
            % cfg.refSlice = cfg.numSlices-1; % use for interleaved order
            % cfg.refSlice = cfg.numSlices; % use for interleaved alt order

    % ------------------------------------------------------------------------------
    switch cfg.WhichProject
        case 'OCDPG'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/OCDPG_config.m']);
        case 'UCLA'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/UCLA_config.m']);
        case 'UCLA_native_MNI'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/UCLA_native_MNI_config.m']);
        case 'NYU_2'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/NYU_2_config.m']);
        case 'COBRE'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/COBRE_config.m']);
        case 'Beijing_Zang'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/Beijing_Zang_config.m']);
        case 'COBRE_HCTSA'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/COBRE_HCTSA_config.m']);
        case 'UCLA_HCTSA'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/UCLA_HCTSA_config.m']);
        case 'NAMIC_HCTSA'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/NAMIC_HCTSA_config.m']);
        case 'conc_TMS_FMRI'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/conc_TMS_FMRI_config.m']);
        case 'Activebrains_pre'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/Activebrains_pre_config.m']);
        case 'TBS_fMRI'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/TBS_fMRI_config.m']);
        case 'EAT'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/EAT_config.m']);
        case 'OCDPG_DCM'
            run([cfg.parentdir,'Scripts/rs-fMRI/studies/OCDPG_DCM_config.m']);
    end

    % ------------------------------------------------------------------------------
    % conc_TMS_FMRI
    % ------------------------------------------------------------------------------
    if ismember('conc_TMS_FMRI',cfg.WhichProject,'rows')
        if exist(cfg.t1dir) == 0
            fprintf(1,'\t\t Initialising t1dir\n')
            mkdir(cfg.t1dir)
        elseif exist(cfg.t1dir) == 7
            fprintf(1,'\t\t Cleaning and re-initialising t1dir\n')
            rmdir(cfg.t1dir,'s')
            mkdir(cfg.t1dir)
        end

        fprintf(1,'\t\t Copying t1\n')
        copyfile([cfg.datadir,cfg.subject,'/anat/',cfg.t1name,'*'],cfg.t1dir)

        if ismember('FDown_Scan1',cfg.WhichSessScan,'rows') | ismember('FDown_Scan2',cfg.WhichSessScan,'rows')
            fprintf(1,'\t\t Copying face down t1 as well...\n')
            copyfile([cfg.datadir,cfg.subject,'/anat/',cfg.t14norm,'*'],cfg.t1dir)
        end
    end

    % ------------------------------------------------------------------------------
    % run prepro_base
    runBase = 1;
    % ------------------------------------------------------------------------------
    if runBase == 1
        [cfg.tN,cfg.gm,cfg.wm,cfg.csf,cfg.epiBrainMask,cfg.t1BrainMask,cfg.BrainMask,cfg.gmmask,cfg.wmmask,cfg.csfmask,cfg.dvars,cfg.dvarsExtract,cfg.fdThr,cfg.dvarsThr,cfg.exclude,cfg.outEPI,cfg.native] = prepro_base(cfg);
        save([cfg.preprodir,'cfg_prepro_base.mat'],'cfg');
    elseif runBase == 0
        % assumes 6P has been run
        temp = load([cfg.preprodir,'6P/cfg.mat']);
        cfg.tN = temp.cfg.tN;
        cfg.gm = temp.cfg.gm;
        cfg.wm = temp.cfg.wm;
        cfg.csf = temp.cfg.csf;
        cfg.epiBrainMask = temp.cfg.epiBrainMask;
        cfg.t1BrainMask = temp.cfg.t1BrainMask;
        cfg.BrainMask = temp.cfg.BrainMask;
        cfg.gmmask = temp.cfg.gmmask;
        cfg.wmmask = temp.cfg.wmmask;
        cfg.csfmask = temp.cfg.csfmask;
        cfg.dvars = temp.cfg.dvars;
        cfg.dvarsExtract = temp.cfg.dvarsExtract;
        cfg.fdThr = temp.cfg.fdThr;
        cfg.dvarsThr = temp.cfg.dvarsThr;
        cfg.exclude = temp.cfg.exclude;
        cfg.outEPI = temp.cfg.outEPI;
    end

    % ------------------------------------------------------------------------------
    % noise correction and time series
    % ------------------------------------------------------------------------------
    % Enter the names of the noise corrections strategies you want to use into the cell 'noiseOptions'
    % This script will then loop over each strategy
    % If you only want to run one then just use something like: noiseOptions = {'24P+aCC'};

    % All pipelines
    % noiseOptions = {'6P','6P+2P','6P+2P+GSR','24P','24P+8P','24P+8P+4GSR','12P+aCC','24P+aCC','12P+aCC50','24P+aCC50','24P+aCC+4GSR','24P+aCC50+4GSR','ICA-AROMA+2P','ICA-AROMA+2P+GSR','ICA-AROMA+8P','ICA-AROMA+8P+4GSR','24P+8P+4GSR+SpikeReg'};
    noiseOptions = {'ICA-AROMA+2P','ICA-AROMA+2P+GSR'};

    % If subject was not marked for exclusion for scrubbing, then append the JP14 pipelines
    if cfg.exclude == 0 & cfg.intnorm == 1 & cfg.runBandpass == 1
        fprintf(1, '\n\t\t Adding JP14 pipelines \n\n');
        noiseOptions2Append = {'24P+4P+2GSR+JP14Scrub'};
        noiseOptions = [noiseOptions,noiseOptions2Append];
    end

    % Starting at no options for the time being.
    noiseOptions = [];

    % Loop over noise correction options
    for i = 1:length(noiseOptions)

        % Set noise correction
        cfg.removeNoise = noiseOptions{i};

        % Override smoothing order if using ICA-AROMA
        if any(~cellfun('isempty',strfind({cfg.removeNoise},'ICA-AROMA'))) == 1
            fprintf(1, '\n\t\t !!!! Forcing smoothing order to ''before'' for ICA-AROMA !!!! \n\n');
            cfg.smoothing = 'before';
        else
            cfg.smoothing = smoothing;
        end

        % define inputs to noise correction
        switch cfg.smoothing
            case {'after','none'}
                if any(~cellfun('isempty',strfind({cfg.removeNoise},'JP14Scrub'))) == 0
                    % If we run smoothing AFTER noise correction, then the input file is unsmoothed epi from prepro_base
                    cfg.CleanIn = cfg.outEPI{1};
                    % and, the nuisance inputs are the same image
                    cfg.NuisanceIn_wm = cfg.outEPI{1};
                    cfg.NuisanceIn_csf = cfg.outEPI{1};
                elseif any(~cellfun('isempty',strfind({cfg.removeNoise},'JP14Scrub'))) == 1
                    % If Power's scrubbing then its the power equivalent instead
                    cfg.CleanIn = cfg.outEPI{3};
                    cfg.NuisanceIn_wm = cfg.outEPI{3};
                    cfg.NuisanceIn_csf = cfg.outEPI{3};
                end
            case 'before'
                if any(~cellfun('isempty',strfind({cfg.removeNoise},'JP14Scrub'))) == 0
                    % If we run smoothing BEFORE noise correction, then the input file is smoothed epi from prepro_base
                    cfg.CleanIn = cfg.outEPI{2};
                    % and, the nuisance inputs are the same image
                    cfg.NuisanceIn_wm = cfg.outEPI{2};
                    cfg.NuisanceIn_csf = cfg.outEPI{2};
                elseif any(~cellfun('isempty',strfind({cfg.removeNoise},'JP14Scrub'))) == 1
                    % If Power's scrubbing then its the power equivalent instead
                    cfg.CleanIn = cfg.outEPI{4};
                    cfg.NuisanceIn_wm = cfg.outEPI{4};
                    cfg.NuisanceIn_csf = cfg.outEPI{4};
                end
        end

        % ------------------------------------------------------------------------------
        % run prepro_noise
        % ------------------------------------------------------------------------------
        [cfg.noiseTS,cfg.outdir,cfg.noiseTSz] = prepro_noise(cfg);

        % ------------------------------------------------------------------------------
        % extract time series
        runTS = 0;
        % ------------------------------------------------------------------------------
        if runTS == 1
            cd(cfg.outdir)

            cfg.parcFiles = {[cfg.parentdir,'ROIs/Gordon/Parcels_MNI_222.nii'],...
                            [cfg.parentdir,'ROIs/Power/Power.nii'],...
                            [cfg.parentdir,'ROIs/TriStri/TriStri.nii'],...
                            [cfg.parentdir,'ROIs/DiMartino/SphereParc02.nii'],...
                            [cfg.parentdir,'ROIs/HCP/MMP_in_MNI_asym_222_continuousLabels.nii'],...
                            [cfg.parentdir,'ROIs/AAL/AAL_2mm/raal.nii']};

            cfg.parcWeightGM = {'yes',...
                                'yes',...
                                'no',...
                                'no',...
                                'yes',...
                                'yes'};

            % Set input image for time series extraction
            cfg.ExtractIn = 'epi_prepro.nii';

            % Initialise roi time series variable
            cfg.roiTS = [];

            % Loop over parcellation files
            for i = 1:length(cfg.parcFiles)
                % Set parcellation file
                cfg.parcFile = cfg.parcFiles{i};
                % set GM weight
                cfg.weightGM = cfg.parcWeightGM{i};
                % extract time series
                cfg.roiTS{i} = prepro_extractTS_FSL(cfg);
            end

            cfg = rmfield(cfg,{'parcFile','weightGM'});
        end

        % Save data
        save('cfg.mat','cfg')

        % ------------------------------------------------------------------------------
        % Compress final outputs
        % ------------------------------------------------------------------------------
        fprintf('\n\t\t ----- Compressing %s outputs ----- \n\n',cfg.removeNoise);
        if any(size(dir([cfg.outdir '*.nii' ]),1))
            cd(cfg.outdir)
            gzip('*.nii')
            pause(5)
            delete('*.nii')
        end
    end

    % ------------------------------------------------------------------------------
    % Compress base & t1 outputs
    % ------------------------------------------------------------------------------
    fprintf('\n\t\t ----- Compressing base outputs ----- \n\n');
    if any(size(dir([cfg.preprodir '*.nii' ]),1)) == 1
        cd(cfg.preprodir)
        gzip('*.nii')
        pause(5)
        delete('*.nii')
    end

    if any(size(dir([cfg.t1dir '*.nii' ]),1)) == 1
        cd(cfg.t1dir)
        gzip('*.nii')
        pause(5)
        delete('*.nii')
    end

    if any(size(dir([cfg.rawdir '*.nii' ]),1)) == 1
        cd(cfg.rawdir)
        gzip('*.nii')
        pause(5)
        delete('*.nii')
    end
    fprintf('\n\t\t ----- Finished. ----- \n\n');
end
