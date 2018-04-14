% A function to take the output from ANTs and apply this to a new epi
function applyANTSrigidAlignmentToEPI(epi,antsAlignMatrix,epi_output)

% Grab the qform from the epi
[~,result] = system(['fslorient -getqform ' epi]);
qform44 = reshape(str2num(result),[4,4]);

% Have to take the transpose
qform44 = qform44.';

% Now need to make a sform, use a function found in lead dps to translate the ANTS transformation into a sform44
load(antsAlignMatrix);

% now transform this to get a world to world transformation (i.e. once the data is in qforms)
mat=ea_antsmat2mat(AffineTransform_double_3_3,fixed);

% use this to develop the sform:
sform44 = mat*qform44;

% Now make a copy of the epi
system(['cp ' epi ' ' epi_output]);

% Now we will use this to apply it to the nifti
system(['fslorient -setsformcode ' 2 ' ' epi_output]);

% because we took the transpose of the qform44 above, to get it back into fsl check this again
system(['fslorient -setsform ' num2str(reshape(sform44.',[1,16])) ' ' epi_output]);


end