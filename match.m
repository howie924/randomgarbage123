% num = match(image1, image2)
%
% This function reads two images, finds their SIFT features, and
%   displays lines connecting the matched keypoints.  A match is accepted
%   only if its distance is less than distRatio times the distance to the
%   second closest match.
% It returns the number of matches displayed.
%
% Example: match('scene.pgm','book.pgm');

function [loc1,loc2,num] = match(image1, image2)

% Find SIFT keypoints for each image
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);
%
% if size(loc1,1)<10
%     loc1 = 1;
%     loc2 = 1;
%     num = 0;
% else
%     if size(loc2,1)<10
%         loc1 = 1;
%         loc2 = 1;
%         num = 0;
%     else
% For efficiency in Matlab, it is cheaper to compute dot products between
%  unit vectors rather than Euclidean distances.  Note that the ratio of
%  angles (acos of dot products of unit vectors) is a close approximation
%  to the ratio of Euclidean distances for small angles.
%
% distRatio: Only keep matches in which the ratio of vector angles from the
%   nearest to second nearest neighbor is less than distRatio.
distRatio = 0.5;

% For each descriptor in the first image, select its match to second image.
des2t = des2';                          % Precompute matrix transpose
des1t = des1';                          % Precompute matrix transpose
for i = 1 : size(des1,1)
    dotprods = des1(i,:) * des2t;        % Computes vector of dot products
    [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results
    
    % Check if nearest neighbor has angle less than distRatio times 2nd.
    if (vals(1) < distRatio * vals(2))
        dotprods2 = des2(indx(1),:) * des1t;        % Computes vector of dot products
        [vals2,indx2] = sort(acos(dotprods2));  % Take inverse cosine and sort results
        % could change to the region around
        if (vals2(1) < distRatio * vals2(2))
            if (indx2(1) == i);
                match(i) = indx(1);
                
            else
                match(i) = 0;
            end
        else
            match(i) = 0;
        end
    else
        match(i) = 0;
    end
end

num = sum(match > 0);
if num >= 1
    % Create a new image showing the two images side by side.
    im3 = appendimages(im1,im2);
    
    % Show a figure with lines joining the accepted matches.
    figure('Position', [100 100 size(im3,2) size(im3,1)]);
    colormap('gray');
    imagesc(im3);
    hold on;
    cols1 = size(im1,2);
    for i = 1: size(des1,1)
        
        if (match(i) > 0)
            
            line([loc1(i,2) loc2(match(i),2)+cols1], ...
                [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
        end
    end
    hold off;
end
fprintf('Found %d matches.\n', num);
loc1 = size(loc1,1);
loc2 = size(loc2,1);
end
% end

