% Where the subjects' directories are
cfg.datadir = '/home/lindenmp/kg98/Morrowj/PROJECTS/conc_TMS_FMRI/rawdata/';

switch cfg.WhichSessScan
    case 'FUp_Scan1'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/'];
        cfg.preprodir = [cfg.rawdir,'prepro_FUp1/'];
        cfg.EPI = [cfg.subject,'_task-FUP1_bold.nii'];

        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat_FUp/']; % DLPFC, SFG and SHAM
        cfg.t1name = [cfg.subject,'_FUP_T1w.nii'];
    case 'FUp_Scan2'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/'];
        cfg.preprodir = [cfg.rawdir,'prepro_FUp2/'];
        cfg.EPI = [cfg.subject,'_task-FUP2_bold.nii'];

        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat_FUp/']; % TPJ
        cfg.t1name = [cfg.subject,'_FUP_T1w.nii'];
    case 'FDown_Scan1'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/'];
        cfg.preprodir = [cfg.rawdir,'prepro_FDown1/'];
        cfg.EPI = [cfg.subject,'_task-FDOWN1_bold.nii'];

        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat_FDown/']; % TPJ
        cfg.t1name = [cfg.subject,'_FDOWN_T1w.nii'];
        cfg.t14norm = [cfg.subject,'_FUP_T1w.nii'];
    case 'FDown_Scan2'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/'];
        cfg.preprodir = [cfg.rawdir,'prepro_FDown2/'];
        cfg.EPI = [cfg.subject,'_task-FDOWN2_bold.nii'];

        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat_FDown/']; % TPJ
        cfg.t1name = [cfg.subject,'_FDOWN_T1w.nii'];
        cfg.t14norm = [cfg.subject,'_FUP_T1w.nii'];
end

% the path and filename of the template in MNI space to which everything
% will be normalized
cfg.mni_template = [cfg.spmdir,'templates/T1.nii'];

% preprocessing settings
% length of time series (no. vols)
cfg.N = 186;
% Repetition time of acquistion in secs
cfg.TR = 2.76;
% Number of slices in EPI volumes.
cfg.numSlices = 44;
% Vector defining acquisition order of EPI slices (necessary for slice-timing correction.
% See help of slicetime_epis.m for guidance on how to define)
cfg.order = [1:2:cfg.numSlices,2:2:cfg.numSlices]; % interleaved
% Reference slice for slice timing acquisition. See SlicetimeEPI.m for guidance on how to define.
cfg.refSlice = cfg.numSlices-1; % use for interleaved order

% Scalar value indicating spatial smoothing kernal size in mm.
cfg.kernel = 6;
% Low-pass cut-off for bandpass filter in Hz (e.g., .08)
cfg.LowPass = 0.08;
% Hi-pass cut-off for bandpass filter in Hz (e.g., .008)
cfg.HighPass = 0.008;