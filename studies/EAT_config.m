%% EAT project, edited from the GoC project
% Where the subjects' directories are
cfg.datadir = '/projects/kg98/Meadhbh/EAT_project/datadir/rawdata/';

switch cfg.WhichSessScan
    case 'Sess1_Scan1'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/']; %%have renamed spaces here with underscores
        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat/'];

        % where the processed epi 4d files will be output to from prepro_base
        cfg.preprodir = [cfg.rawdir,'prepro_run-01/'];
        % file name of EPI 4d file
        cfg.EPI = [cfg.subject,'_task-eat_run-01_bold.nii'];
    case 'Sess1_Scan2'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/']; %%have renamed spaces here with underscores
        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat/'];

        % where the processed epi 4d files will be output to from prepro_base
        cfg.preprodir = [cfg.rawdir,'prepro_run-02/'];
        % file name of EPI 4d file
        cfg.EPI = [cfg.subject,'_task-eat_run-02_bold.nii'];
    case 'Sess1_Scan3'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/']; %%have renamed spaces here with underscores
        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat/'];

        % where the processed epi 4d files will be output to from prepro_base
        cfg.preprodir = [cfg.rawdir,'prepro_run-03/'];
        % file name of EPI 4d file
        cfg.EPI = [cfg.subject,'_task-eat_run-03_bold.nii'];
    case 'Sess1_Scan4'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/']; %%have renamed spaces here with underscores
        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat/'];

        % where the processed epi 4d files will be output to from prepro_base
        cfg.preprodir = [cfg.rawdir,'prepro_run-04/'];
        % file name of EPI 4d file
        cfg.EPI = [cfg.subject,'_task-eat_run-04_bold.nii'];
    case 'Sess1_Scan5'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/']; %%have renamed spaces here with underscores
        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat/'];

        % where the processed epi 4d files will be output to from prepro_base
        cfg.preprodir = [cfg.rawdir,'prepro_run-05/'];
        % file name of EPI 4d file
        cfg.EPI = [cfg.subject,'_task-eat_run-05_bold.nii'];
    case 'Sess1_Scan6'
        % where the unprocessed EPI 4d file is
        cfg.rawdir = [cfg.datadir,cfg.subject,'/func/']; %%have renamed spaces here with underscores
        % Directory where the t1 is
        cfg.t1dir = [cfg.datadir,cfg.subject,'/anat/'];

        % where the processed epi 4d files will be output to from prepro_base
        cfg.preprodir = [cfg.rawdir,'prepro_run-06/'];
        % file name of EPI 4d file
        cfg.EPI = [cfg.subject,'_task-eat_run-06_bold.nii'];
end

% Directory where the t1 is
cfg.t1dir = [cfg.datadir,cfg.subject,'/anat/'];
% name of t1 file.
cfg.t1name = [cfg.subject,'_T1w.nii'];

% the path and filename of the template in MNI space to which everything
% will be normalized
cfg.mni_template = [cfg.spmdir,'templates/T1.nii'];

% preprocessing settings
% length of time series (no. vols)
cfg.N = 116; %116mb
% Repetition time of acquistion in secs
cfg.TR = 2.46; %must check this EAT %2460ms-mb

% Number of slices in EPI volumes.
cfg.numSlices = 44; %not sure why this was empty %44mb
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