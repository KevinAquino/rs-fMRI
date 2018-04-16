function [image_matrix] = generateSliceSummary(filename,sliceChoice,zoomedSize,fontScale,imgScale,cmap,ROI_box,orientation, mask,isabs,nomean)
% Function here to generate summary images, saves them as pngs for everyone
% to see.
% usage:

% out = createSummaryImages(filenames,imageType,saveFolder,sliceChoice)
%       filenames   = list of filenames to load, must be in NIFTI-PAIR format
%       imageType   = list of strings that label each image
%       saveFolder  = where to save the images
%       sliceChoice = slices that I want to display out in a png
% Kevin Aquino 2018
% <kevin.aquino@monash.edu.au>
% Taken from: code i wrote nottingham's offline fMRI QC's pipeline

if(nargin<2)
    sliceChoice = 1:2;
end

if(nargin<3)
    zoomedSize = [];
end

if(nargin<4)
    fontScale = 20;
end

if(nargin<5)
    imgScale = [];
end

if(nargin<6)
    cmap = hot(255).';
end

if(nargin<7)
    ROI_box = [];
end

if(nargin<8)
    orientation = 3;
end

if(nargin<11)
    nomean = 0;
end

% Now loading in data using freesurfer's MRIread.
data_struct = MRIread(filename);
data = data_struct.vol;

% Just here to add in abs if need be
if(isabs)
    data = abs(data);
end    

if(nomean)
    data = data(:,:,:,1);
else
    data = mean(data,4);
end

% This here changes the image orientation if you need to..
switch orientation
    case 2
        data = permute(data,[1 3 2]);        
    case 1
        data = permute(data,[2 3 1]);        
    otherwise
        %here do nothing for now, set up in the normal orientation
end

if(orientation~=3)
    sliceChoice = 1:size(data,3);    
    if(~isempty(ROI_box));
        disp('Note that ROI will not draw in this orientation... will fix in future!!');
        ROI_box=[];
    end

end
%     figure;
for sc=1:length(sliceChoice),
    dat = data(:,:,sliceChoice(sc)).';

    if(~isempty(imgScale))
        if(imgScale>0)
            dat2 = (dat/imgScale);
        else
            dat2 = (dat/max(dat(:)));
        end                
    else
        dat2 = (dat/max(dat(:)));
    end
    
    if ieNotDefined('mask')
        mask = 0;
        
    elseif mask == 1
        % masking 5% of max values (optional)
        dat2(dat2<0.05*max(dat2(:))) = 0;
    end
    
    dat2 = uint8(reshape((meshData2Colors(dat2(:),cmap,[0 1])).'*255,[size(dat) 3]));
%     keyboard
    
    % Here is for zooming in.
    if(~isempty(zoomedSize))
        dat2 = dat2(zoomedSize(1,1):zoomedSize(1,2),zoomedSize(2,1):zoomedSize(2,2),:);
    end
    dat2 = dat2(end:-1:1,:,:);
    
    % Here is a fix in case computer graphics toolbox is not installed.   
%     try
%         dat2 = insertText(dat2,[1,1],['slice_' num2str(sliceChoice(sc))],'BoxColor',[0 0 255],'TextColor',[255 255 255],'FontSize',fontScale);
% %         dat2 = insertString(dat2,[1 1],['slice_' num2str(sliceChoice(sc))],[0 0 255],[255 255 255],fontScale);
%     catch
%         dat2 = dat2;
%     end
    
    if(~isempty(ROI_box) && ismember(sc,ROI_box.slice))    
      try
        dat2=insertShape(dat2,'Rectangle',[ROI_box.x ROI_box.y ROI_box.width ROI_box.height],'Color',[255 255 255],'LineWidth',3);
      catch
        % BoxColor = [255 255 255];
        dat2(ROI_box.y:ROI_box.height+ROI_box.y,[ROI_box.x-[0 1] ROI_box.width+ROI_box.x+[0 1]],:) = 255;
        dat2([ROI_box.y-[0 1] ROI_box.height+ROI_box.y+[0 1]],ROI_box.x:ROI_box.width+ROI_box.x,:) = 255;
      end
    end
    dats{sc} = dat2;
end

% Always make sure this is eight
no_columns = 8;

if(length(sliceChoice)<=no_columns)
    image_matrix = cell2mat(dats);
elseif(length(sliceChoice)>no_columns)
    
    no_rows = ceil(length(sliceChoice)/no_columns);
    totalImages = no_rows*no_columns;
    newMatrix = cell(no_rows,no_columns);
    newMatrix(1:length(sliceChoice)) = dats;
    
    % Need to do this faster perhaps..
    for j=length(sliceChoice)+1:totalImages,
        newMatrix{j} = uint8(zeros(size(dats{1})));
    end
    image_matrix = cell2mat(newMatrix(reshape(1:totalImages,no_columns,no_rows).'));
else
    disp('error!, something went wrong');
    keyboard;
    return
end


