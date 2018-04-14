% Where the subjects' directories are
cfg.datadir = [cfg.parentdir_scratch,'ResProjects/rfMRI_denoise/NYU_2/data/'];

% where the unprocessed EPI 4d file is
% cfg.WhichSessScan = 'Sess1_Scan1';
switch cfg.WhichSessScan
    case 'Sess1_Scan1'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/session_1/func_1/'];
        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/session_1/anat_1/'];
    case 'Sess1_Scan2'
        cfg.rawdir = [cfg.datadir,cfg.subject,'/session_1/func_2/'];
        cfg.t1dir = [cfg.datadir,cfg.subject,'/session_1/anat_1/'];
    case 'Sess2_Scan1'
        cfg.rawdir = [cfg.datadir,cfg.subject,'/session_2/func_1/'];
        cfg.t1dir = [cfg.datadir,cfg.subject,'/session_2/anat_1/'];
end

% where the processed epi 4d files will be output to from prepro_base
cfg.preprodir = [cfg.rawdir,'prepro/'];

% file name of EPI 4d file
cfg.EPI = [cfg.subject,'_task-rest_bold.nii'];
% name of t1 file.
cfg.t1name = [cfg.subject,'_T1w.nii'];

% the path and filename of the template in MNI space to which everything
% will be normalized
cfg.mni_template = [cfg.spmdir,'templates/T1.nii'];

% preprocessing settings
% length of time series (no. vols)
cfg.N = 180;
% Repetition time of acquistion in secs
cfg.TR = 2;
% Number of slices in EPI volumes.
cfg.numSlices = 33;
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